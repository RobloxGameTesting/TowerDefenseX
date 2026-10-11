local TurretClass = {}
TurretClass.__index = TurretClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Utilities = require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local RotatingBarrelHandlerClass = require(script.Parent.Parent:WaitForChild("RotatingBarrelHandlerClass"))
local CLIENT_DEFAULT_FPS = _G.CLIENT_DEFAULT_FPS
local v = 0.25 * CLIENT_DEFAULT_FPS
local v2 = false

local function ConstrainAxis(value: number, p: number, flag: boolean?, value2: number?, value3: number?) -- 3 equivalent calls inferred from this helper
	if flag then
		return (math.clamp(value, p + math.rad(value2 or -1e999), p + math.rad(value3 or 1e999)))
	end

	return p
end

local function ConstrainRotation(cframe: CFrame, cframe2: CFrame, data)
	if not data then
		return cframe
	end

	local orientation, v3, v4 = cframe:ToOrientation()
	local orientation2, v5, v6 = cframe2:ToOrientation()

	if data.InvertX then
		orientation *= -1
	end

	if data.InvertY then
		v3 *= -1
	end

	if data.InvertZ then
		v4 *= -1
	end

	local cframe3 = CFrame.new(cframe.Position)
	orientation2 = ConstrainAxis(orientation, orientation2, data.CanRotateX, data.MinRotationX, data.MaxRotationX) -- inferred equivalent call
	v5 = ConstrainAxis(v3, v5, data.CanRotateY, data.MinRotationY, data.MaxRotationY) -- inferred equivalent call
	v6 = ConstrainAxis(v4, v6, data.CanRotateZ, data.MinRotationZ, data.MaxRotationZ) -- inferred equivalent call
	return cframe3 * CFrame.fromOrientation(orientation2, v5, v6)
end

local function GetPivot(instance, child) -- 2 equivalent calls inferred from this helper
	local pivotWeld = child:FindFirstChild("PivotWeld")

	if pivotWeld then
		if pivotWeld:IsA("StringValue") then
			return (Utilities.TryGetInstanceFromPath(instance, pivotWeld.Value))
		end

		if pivotWeld:IsA("ObjectValue") then
			return pivotWeld.Value
		end
	end
end

function TurretClass.New(instance, data, speedMultiplier: number)
	local primaryPart = instance.PrimaryPart
	local child = instance:FindFirstChild(data.ModelName)
	assert(child, `TurretModel {data.ModelName} not found`)
	local bone = GetPivot(instance, child) or primaryPart:FindFirstChild("Pivot_Turret_" .. data.ModelName) -- inferred equivalent call

	if not bone then
		local pivot_Turret = child:FindFirstChild("Pivot_Turret")

		if pivot_Turret then
			local autoWeldToInstanceName = data.AutoWeldToInstanceName

			if autoWeldToInstanceName then
				primaryPart = Utilities.TryGetInstanceFromPath(instance, autoWeldToInstanceName)

				if not primaryPart then
					warn("TurretClass.New: AutoWeldToInstanceName not found", autoWeldToInstanceName)
				end
			end

			bone = Utilities.Motor6D(primaryPart, pivot_Turret)
			bone.Name = "Pivot_Turret_" .. data.ModelName
		end
	end

	assert(bone, `TurretPivot not found and couldn't be auto created for {instance.Name} in {data.ModelName}`)
	local autoWeldToPivot = child:GetAttribute("AutoWeldToPivot")

	if autoWeldToPivot then
		local pivot_Turret = child:FindFirstChild("Pivot_Turret")

		if pivot_Turret then
			for _, part in pairs(child:GetChildren()) do
				if part:IsA("BasePart") and part ~= pivot_Turret then
					Utilities.Weld(pivot_Turret, part)
				end
			end
		else
			warn("Could not find Pivot_Gun for auto welding in turret model", child:GetFullName())
		end
	end

	local rotationOffset = data.RotationOffset or CFrame.Angles(0, 0, 0)
	local v3 = Utilities.TryReadChildValue(bone, "RotationOffset")

	if v3 then
		rotationOffset *= CFrame.Angles(math.rad(v3.X), math.rad(v3.Y), (math.rad(v3.Z)))
	end

	local overrideLerpAlphaFactor = data.OverrideLerpAlphaFactor
	local isA = bone:IsA("Bone")
	local parent = nil
	local c0

	if isA then
		parent = bone.Parent

		if not parent then
			warn("TurretClass.New: ParentBone not found for", bone:GetFullName())
			return
		end

		if parent:IsA("Bone") then
			c0 = bone.CFrame * rotationOffset
		else
			warn("TurretClass.New: ParentBone is not a Bone for", bone:GetFullName())
			return
		end
	else
		c0 = bone.C0
	end

	local result = {
		TurretPivot = bone,
		IsBone = isA,
		ParentBone = parent,
		TurretPivotOriginalC0 = c0,
		TurretRotationOffset = rotationOffset,
		TurretRotationConstraintConfig = data.RotationConstraintConfig,
		TurretRotationConstraintConfigCloned = false,
		UseBurstIndexForGun = data.UseBurstIndexForGun,
		ForceMaintainC0Position = data.ForceMaintainC0Position,
		GoalC0 = c0,
		LerpRotationIfContinuousEffectsOn = data.LerpRotationIfContinuousEffectsOn,
		AlwaysLerpRotation = data.AlwaysLerpRotation,
		LerpAlpha = overrideLerpAlphaFactor and CLIENT_DEFAULT_FPS * overrideLerpAlphaFactor or v,
		GunData = {},
		SpeedMultiplier = speedMultiplier,
		WarnedMissingPivotParts = false
	}

	if result.TurretRotationConstraintConfig then
		for attributeName, _ in pairs(result.TurretRotationConstraintConfig) do
			local attribute = child:GetAttribute(attributeName)

			if attribute == nil then
				continue
			end

			if not result.TurretRotationConstraintConfigCloned then
				result.TurretRotationConstraintConfig = table.clone(result.TurretRotationConstraintConfig)
				result.TurretRotationConstraintConfigCloned = true
			end

			result.TurretRotationConstraintConfig[attributeName] = attribute
		end
	end

	setmetatable(result, TurretClass)
	result:_InitializeGuns(instance, child, data.TurretGunConfigs, autoWeldToPivot)
	return result
end

function TurretClass.ToggleTurretAiming()
	v2 = not v2
end

function TurretClass:_InitializeGuns(instance, instance2, items, flag: boolean?)
	for _, item in pairs(items) do
		local child = instance2:FindFirstChild(item.ModelName)
		assert(child, "GunModel not found")
		local canRotate = not item.NoRotate
		local rotationOffset = item.RotationOffset or CFrame.Angles(0, 0, 0)
		local parent = nil
		local bone, isBone, c0

		if canRotate or item.ForceAutoWeld then
			bone = GetPivot(instance, child) or child:FindFirstChild("Pivot_Gun_" .. item.ModelName) -- inferred equivalent call

			if not bone then
				local pivot_Turret = instance2:FindFirstChild("Pivot_Turret")
				local pivot_Gun = child:FindFirstChild("Pivot_Gun")

				if pivot_Gun then
					bone = Utilities.Motor6D(pivot_Turret, pivot_Gun)
					bone.Name = "Pivot_Gun_" .. item.ModelName
				end
			end

			assert(bone, `GunPivot not found and could not be automatically created for {instance.Name}`)
			isBone = bone:IsA("Bone")
			local _cframe = isBone and bone.CFrame or bone.C0

			if isBone then
				parent = bone.Parent

				if not parent then
					warn("TurretClass:_InitializeGuns: ParentBone not found for", bone:GetFullName())
					continue
				end

				if parent:IsA("Bone") then
					c0 = bone.CFrame * rotationOffset
				else
					warn("TurretClass:_InitializeGuns: ParentBone is not a Bone for", bone:GetFullName())
					continue
				end
			else
				c0 = bone.C0
			end
		else
			isBone = false
		end

		if flag then
			local pivot_Gun = child:FindFirstChild("Pivot_Gun")

			if pivot_Gun then
				for _, part in pairs(child:GetChildren()) do
					if part:IsA("BasePart") and part ~= pivot_Gun then
						Utilities.Weld(pivot_Gun, part)
					end
				end
			else
				warn("Could not find Pivot_Gun for auto welding in gun model", child:GetFullName())
			end
		end

		local animationTrack

		if (item.Animated or child:FindFirstChild("Animations")) and not child:GetAttribute("NoAnimations") then
			animationTrack = Utilities.MakeAnimationTrack(child)

			if not animationTrack then
				warn("TurretClass:_InitializeGuns: Animation not found for", child:GetFullName())
			end
		end

		local rotatingBarrelHandlers = {}
		local rotatingBarrelData = item.RotatingBarrelData
		local rotatingBarrelData2 = instance:FindFirstChild("RotatingBarrelData")
			or child:FindFirstChild("RotatingBarrelData")

		if rotatingBarrelData2 then
			rotatingBarrelData = require(rotatingBarrelData2)
		end

		if rotatingBarrelData then
			for _, v3 in pairs(rotatingBarrelData) do
				local v4 = RotatingBarrelHandlerClass.New(child, v3, nil, instance)

				if v4 then
					table.insert(rotatingBarrelHandlers, v4)
				end
			end
		end

		local overrideLerpAlphaFactor = item.OverrideLerpAlphaFactor
		local v3 = {
			CanRotate = canRotate,
			GunPivot = bone,
			IsBone = isBone,
			ParentBone = parent,
			GunPivotOriginalC0 = canRotate and c0,
			GunRotationOffset = rotationOffset,
			GunRotationConstraintConfig = item.RotationConstraintConfig,
			GunRotationConstraintConfigCloned = false,
			ContinuousEffectsPlaying = false,
			TimeSinceLastAttack = 1e999,
			HasContinuousEffects = item.HasContinuousEffects,
			ContinuousEffectStopDelay = item.ContinuousEffectStopDelay,
			SoundGroupPlaying = false,
			SoundGroupName = item.SoundGroupName,
			SoundGroupStopDelay = item.SoundGroupStopDelay,
			EmitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(child, self.SpeedMultiplier),
			AnimationTrack = animationTrack,
			RotatingBarrelHandlers = rotatingBarrelHandlers,
			GoalC0 = canRotate and c0,
			AlwaysLerpRotation = item.AlwaysLerpRotation,
			LerpAlpha = overrideLerpAlphaFactor and CLIENT_DEFAULT_FPS * overrideLerpAlphaFactor or v
		}

		if v3.GunRotationConstraintConfig then
			for attributeName, _ in pairs(v3.GunRotationConstraintConfig) do
				local attribute = child:GetAttribute(attributeName)

				if attribute == nil then
					continue
				end

				if not v3.GunRotationConstraintConfigCloned then
					v3.GunRotationConstraintConfig = table.clone(v3.GunRotationConstraintConfig)
					v3.GunRotationConstraintConfigCloned = true
				end

				v3.GunRotationConstraintConfig[attributeName] = attribute
			end
		end

		if v3.HasContinuousEffects then
			assert(v3.ContinuousEffectStopDelay, "Turret GunData: ContinuousEffectStopDelay not set")
		end

		table.insert(self.GunData, v3)
	end
end

function TurretClass:_ChildGunsContinuousEffectsOn()
	for _, v3 in pairs(self.GunData) do
		if v3.HasContinuousEffects and v3.ContinuousEffectsPlaying then
			return true
		end
	end

	return false
end

function TurretClass:AimAtPosition(vector: Vector3)
	local turretPivot = self.TurretPivot
	local isBone = self.IsBone
	local v3

	if self.IsBone then
		local parentBone = self.ParentBone
		local cframe = CFrame.new(turretPivot.WorldCFrame.Position, vector)
		v3 = ConstrainRotation(
			(parentBone.WorldCFrame:Inverse() * cframe).Rotation + turretPivot.CFrame.Position,
			self.TurretPivotOriginalC0,
			self.TurretRotationConstraintConfig
		) * self.TurretRotationOffset
	else
		local part0 = turretPivot.Part0
		local part1 = turretPivot.Part1

		if part0 and part1 then
			local cframe = CFrame.new(part1.Position, vector)
			v3 = ConstrainRotation(
				part0.CFrame:Inverse() * cframe * turretPivot.C1 * self.TurretRotationOffset,
				self.TurretPivotOriginalC0,
				self.TurretRotationConstraintConfig
			)

			if self.ForceMaintainC0Position then
				v3 = self.TurretPivotOriginalC0 * v3.Rotation
			end
		else
			if not self.WarnedMissingPivotParts then
				self.WarnedMissingPivotParts = true
				warn(`TurretClass:AimAtPosition: TurretPivot {turretPivot:GetFullName()} is missing Part0 or Part1`)
			end

			return
		end
	end

	self.GoalC0 = v3

	if not (self.AlwaysLerpRotation or self.LerpRotationIfContinuousEffectsOn and self:_ChildGunsContinuousEffectsOn() or v2) then
		if isBone then
			turretPivot.CFrame = v3
		else
			turretPivot.C0 = v3
		end
	end

	self:_AimGunsAtPosition(vector)
end

function TurretClass:_AimGunsAtPosition(vector: Vector3)
	for _, v3 in pairs(self.GunData) do
		if not v3.CanRotate then
			continue
		end

		local gunPivot = v3.GunPivot
		local isBone = v3.IsBone
		local v4

		if isBone then
			local parentBone = v3.ParentBone
			local cframe = CFrame.new(gunPivot.WorldCFrame.Position, vector)
			v4 = ConstrainRotation(
				(parentBone.WorldCFrame:Inverse() * cframe).Rotation + gunPivot.CFrame.Position,
				v3.GunPivotOriginalC0,
				v3.GunRotationConstraintConfig
			) * v3.GunRotationOffset
		else
			local part0 = gunPivot.Part0
			local part1 = gunPivot.Part1
			local cframe = CFrame.new(part1.Position, vector)
			v4 = ConstrainRotation(
				part0.CFrame:Inverse() * cframe * gunPivot.C1 * v3.GunRotationOffset,
				v3.GunPivotOriginalC0,
				v3.GunRotationConstraintConfig
			)
		end

		v3.GoalC0 = v4

		if v3.AlwaysLerpRotation or v2 then
			continue
		end

		if isBone then
			gunPivot.CFrame = v4
		else
			gunPivot.C0 = v4
		end
	end
end

function TurretClass:Attacked(p: number?)
	local function PlayGun(state)
		state.EmitterAndSoundWrapper:PlayTriggered()
		state.TimeSinceLastAttack = 0

		if state.HasContinuousEffects and not state.ContinuousEffectsPlaying then
			state.EmitterAndSoundWrapper:PlayContinuous()
			state.ContinuousEffectsPlaying = true
		end

		if state.SoundGroupName and not state.SoundGroupPlaying then
			state.EmitterAndSoundWrapper.SoundWrapper:PlaySoundGroup(state.SoundGroupName)
			state.SoundGroupPlaying = true
		end

		if state.AnimationTrack then
			state.AnimationTrack:Play(nil, nil, self.SpeedMultiplier)
		end

		for _, rotatingBarrelHandler in pairs(state.RotatingBarrelHandlers) do
			rotatingBarrelHandler:Attacked()
		end
	end

	if p and self.UseBurstIndexForGun then
		local v3 = self.GunData[p]

		if v3 then
			PlayGun(v3)
		else
			warn("TurretClass:Attacked: GunData not found at index", p)
		end
	else
		for _, v3 in pairs(self.GunData) do
			PlayGun(v3)
		end
	end
end

function TurretClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, v3 in pairs(self.GunData) do
		v3.EmitterAndSoundWrapper:SpeedMultiplierChanged(speedMultiplier)

		if v3.AnimationTrack then
			v3.AnimationTrack:AdjustSpeed(speedMultiplier)
		end
	end

	self.SpeedMultiplier = speedMultiplier
end

function TurretClass:_LerpTurretToGoal(p: number)
	local turretPivot = self.TurretPivot
	local isBone = self.IsBone
	local goalC0 = self.GoalC0
	local v3 = math.min(p * self.LerpAlpha, 1)

	if not v2 then
		if isBone then
			turretPivot.CFrame = turretPivot.CFrame:Lerp(goalC0, v3)
		else
			turretPivot.C0 = turretPivot.C0:Lerp(goalC0, v3)
		end
	end
end

function TurretClass:Run(p: number)
	for _, v3 in pairs(self.GunData) do
		v3.TimeSinceLastAttack += p

		if v3.ContinuousEffectsPlaying and v3.TimeSinceLastAttack >= v3.ContinuousEffectStopDelay then
			v3.EmitterAndSoundWrapper:StopContinuous()
			v3.ContinuousEffectsPlaying = false
		end

		if v3.SoundGroupPlaying and v3.TimeSinceLastAttack >= v3.SoundGroupStopDelay then
			v3.EmitterAndSoundWrapper.SoundWrapper:StopSoundGroup(v3.SoundGroupName)
			v3.SoundGroupPlaying = false
		end

		for _, rotatingBarrelHandler in pairs(v3.RotatingBarrelHandlers) do
			rotatingBarrelHandler:Run(p)
		end

		if not v3.CanRotate or not v3.AlwaysLerpRotation or v2 then
			continue
		end

		local gunPivot = v3.GunPivot
		local isBone = v3.IsBone
		local goalC0 = v3.GoalC0
		local v4 = math.min(p * v3.LerpAlpha, 1)

		if isBone then
			gunPivot.CFrame = gunPivot.CFrame:Lerp(goalC0, v4)
		else
			gunPivot.C0 = gunPivot.C0:Lerp(goalC0, v4)
		end
	end

	if self.AlwaysLerpRotation or self:_ChildGunsContinuousEffectsOn() then
		self:_LerpTurretToGoal(p)
	end
end

return TurretClass