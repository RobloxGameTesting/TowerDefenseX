local createVector = vector.create
local EradicatorMK2ReworkCustomCodeClass = {}
EradicatorMK2ReworkCustomCodeClass.__index = EradicatorMK2ReworkCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local Utilities = require(common:WaitForChild("Utilities"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

function EradicatorMK2ReworkCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		DamagedWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		LeftArmFallOffWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		RightArmFallOffWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		DeathScreamWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		ArmorPartsMap = {},
		ArmorWelds = {},
		ArmorRemoveInstances = {},
		FlareOriginModel = nil,
		FlareOriginPart = nil,
		FlareActive = false,
		FlareProjectilePart = nil,
		CurrentFlareVelocity = nil,
		TimeLeftForFlare = 0,
		FlareDefaultTime = 259 / 60,
		DeathExplosionTrailWelds = nil,
		HasLanding = false,
		LandingTimeLeft = 0,
		TorsoToRootWeld = nil,
		OriginalTorsoToRootWeldC0 = nil,
		PreviousAbilityName = nil,
		ProjectileOrigins = {},
		_DeathTimingHelpers = {},
		_Wrappers = {}
	}, EradicatorMK2ReworkCustomCodeClass))
end

function EradicatorMK2ReworkCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	self.HasLanding = enemy.Type == Enums.Enemies.EradicatorMK2ReworkWithLanding
	self.LandingTimeLeft = self.HasLanding and 1.65 or 0
	self.TorsoToRootWeld = self.Character:GetTorsoToRootWeld()
	self.OriginalTorsoToRootWeldC0 = self.TorsoToRootWeld.C0

	if self.HasLanding then
		self.TorsoToRootWeld.C0 = CFrame.new(self.OriginalTorsoToRootWeldC0.Position + createVector(0, 150, 0)) * self.OriginalTorsoToRootWeldC0.Rotation
		local spawnLanding = self.CharacterModel:FindFirstChild("SpawnLanding")
		self._Wrappers.LandingEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(
			spawnLanding,
			self.SpeedMultiplier
		)
	end

	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")

	for _, descendant in pairs(characterModel:GetDescendants()) do
		if descendant:GetAttribute("ArmorDetachRemove") then
			table.insert(self.ArmorRemoveInstances, descendant)
		end

		if not descendant:GetAttribute("IsArmor") then
			continue
		end

		if descendant:IsA("BasePart") then
			self.ArmorPartsMap[descendant] = true

			for _, part in pairs(descendant:GetDescendants()) do
				if part:IsA("BasePart") then
					self.ArmorPartsMap[part] = true
				end
			end
		elseif descendant:IsA("Weld") or descendant:IsA("Motor6D") then
			table.insert(self.ArmorWelds, descendant)
		else
			warn("Unknown armor part type", descendant)
		end
	end

	local flareOrigin = characterModel:FindFirstChild("FlareOrigin")
	local flareProjectile = characterModel:FindFirstChild("FlareProjectile")
	self._Wrappers.OriginEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(flareOrigin, self.SpeedMultiplier)
	self.FlareOriginModel = flareOrigin
	self.FlareOriginPart = flareOrigin and flareOrigin.PrimaryPart

	if self.FlareProjectilePart then
		if flareProjectile then
			flareProjectile:Destroy()
		end
	else
		self._Wrappers.FlareEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(
			flareProjectile,
			self.SpeedMultiplier
		)
		self.FlareProjectilePart = flareProjectile.PrimaryPart
		self.FlareProjectilePart.Anchored = true
		self.FlareProjectilePart.Parent = raycastIgnore
	end

	local deathExplosionTrails = characterModel:FindFirstChild("DeathExplosionTrails")
	local welds = {}
	local upperTorso = characterModel:FindFirstChild("Upper Torso")

	if upperTorso then
		for _, weld in pairs(upperTorso:GetChildren()) do
			if weld:IsA("Weld") and weld.Name == "DeathExplosionSpikeTrail" then
				table.insert(welds, weld)
			end
		end
	else
		warn("Missing Upper Torso")
	end

	self.DeathExplosionTrailWelds = welds
	self._Wrappers.DeathExplosionTrailWrapper = WrapperFactory.NewEmitterAndSoundWrapper(
		deathExplosionTrails,
		self.SpeedMultiplier
	)
	local v = Utilities.TryGetInstanceFromPath(characterModel, "Head>DamagedMask")
	local deathEffects = characterModel:FindFirstChild("DeathEffects")
	self.DamagedWrapper:AddFrom(v, self.SpeedMultiplier)

	if deathEffects then
		self.LeftArmFallOffWrapper:AddFrom(deathEffects:FindFirstChild("LeftArm_Arm"), self.SpeedMultiplier)
		self.LeftArmFallOffWrapper:AddFrom(deathEffects:FindFirstChild("LeftArm_Torso"), self.SpeedMultiplier)
		self.RightArmFallOffWrapper:AddFrom(deathEffects:FindFirstChild("RightArm_Arm"), self.SpeedMultiplier)
		self.RightArmFallOffWrapper:AddFrom(deathEffects:FindFirstChild("RightArm_Torso"), self.SpeedMultiplier)
		self.DeathScreamWrapper:AddFrom(deathEffects:FindFirstChild("ScreamVFX1"), self.SpeedMultiplier)
		self.DeathScreamWrapper:AddFrom(deathEffects:FindFirstChild("ScreamVFX2"), self.SpeedMultiplier)
	else
		warn("Missing DeathEffects")
	end

	table.insert(self._Wrappers, self.DamagedWrapper)
	table.insert(self._Wrappers, self.LeftArmFallOffWrapper)
	table.insert(self._Wrappers, self.RightArmFallOffWrapper)
	table.insert(self._Wrappers, self.DeathScreamWrapper)
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._DeathTimingHelpers.LeftArmTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 2.433,
		Callback = function()
			self.LeftArmFallOffWrapper:PlayAll()
		end
	})
	self._DeathTimingHelpers.RightArmTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 7.233,
		Callback = function()
			self.RightArmFallOffWrapper:PlayAll()
		end
	})
	self._DeathTimingHelpers.LeftArmRemoveTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 2.783,
		Callback = function()
			for _, descendant in pairs(characterModel:GetDescendants()) do
				if descendant:GetAttribute("IsLeftArm") then
					descendant:Destroy()
				end
			end
		end
	})
	self._DeathTimingHelpers.RightArmRemoveTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 7.483,
		Callback = function()
			for _, descendant in pairs(characterModel:GetDescendants()) do
				if descendant:GetAttribute("IsRightArm") then
					descendant:Destroy()
				end
			end
		end
	})
	self._DeathTimingHelpers.DeathScream1StartTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 1.65,
		Callback = function()
			self.DeathScreamWrapper:PlayAll()
		end
	})
	self._DeathTimingHelpers.DeathScream1EndTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 2.383,
		Callback = function()
			self.DeathScreamWrapper:StopContinuous()
		end
	})
	self._DeathTimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 9.8,
		Callback = function()
			for _, wrapper in pairs(self._Wrappers) do
				wrapper:StopContinuous()
			end

			self._Wrappers.DeathExplode:PlayAll()
			self._Wrappers.DeathExplosionTrailWrapper:PlayAll()

			for _, deathExplosionTrailWeld in pairs(self.DeathExplosionTrailWelds) do
				local part0 = deathExplosionTrailWeld.Part0
				local part1 = deathExplosionTrailWeld.Part1
				deathExplosionTrailWeld.Enabled = false
				local unit = (part1.Position - part0.Position + createVector(0, 0.25, 0)).Unit
				local mass = part1:GetMass()
				part1:ApplyImpulse(math.random(80, 220) * unit * mass)
			end

			task.delay(1.5, function()
				self._Wrappers.DeathExplosionTrailWrapper:StopContinuous()
			end)
			self.Character:ExplodeParts(2, 5)
		end
	})
end

function EradicatorMK2ReworkCustomCodeClass:Run_FromCharacter(p: number)
	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Run(p)
	end

	if self.FlareActive then
		self.TimeLeftForFlare -= p

		if self.TimeLeftForFlare <= 0 then
			self._Wrappers.FlareEffectWrapper:StopContinuous()
			self.FlareActive = false
			return
		else
			self.CurrentFlareVelocity -= Vector3.new(0, p * 15, 0)
			self.FlareProjectilePart.Position += self.CurrentFlareVelocity * p
		end
	end

	if self.HasLanding and self.LandingTimeLeft > 0 then
		self.LandingTimeLeft -= p

		if self.LandingTimeLeft > 0 then
			local v = math.clamp(self.LandingTimeLeft / 1.65, 0, 1) ^ 0.5
			self.TorsoToRootWeld.C0 = CFrame.new(self.OriginalTorsoToRootWeldC0.Position + Vector3.new(0, v * 150, 0)) * self.OriginalTorsoToRootWeldC0.Rotation
		else
			self.TorsoToRootWeld.C0 = self.OriginalTorsoToRootWeldC0
			self._Wrappers.LandingEffectWrapper:PlayAll()
		end
	end
end

function EradicatorMK2ReworkCustomCodeClass:AbilityUsed(previousAbilityName: string)
	if previousAbilityName == Enums.EnemyAbilities.EradicatorMK2ReworkRage then
		self.Character:ToggleShieldIfExists(true)
		self:_EnterDamagedState()
	end

	self.PreviousAbilityName = previousAbilityName
end

function EradicatorMK2ReworkCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.EradicatorMK2ReworkRage then
		if p2 == "ArmorDetach" then
			local primaryPart = self.CharacterModel.PrimaryPart

			local function GetRandomInitialAngularImpulse() -- 1 equivalent call inferred from this helper
				return (Vector3.new(math.random(-25, 25) / 100, math.random(-35, 35) / 100, 0))
			end

			for _, armorWeld in pairs(self.ArmorWelds) do
				local part1 = armorWeld.Part1

				if not (part1 and (armorWeld.Active or not armorWeld.Enabled)) then
					continue
				end

				armorWeld:Destroy()
				local mass = part1:GetMass()
				local unit = (part1.Position - primaryPart.Position).Unit
				local v = Vector3.new(unit.X, 0, unit.Z).Unit + createVector(0, 3, 0)
				part1.Parent = raycastIgnore
				part1:ApplyImpulse(math.random(6, 11) * v * mass * 2)
				part1:ApplyAngularImpulse(GetRandomInitialAngularImpulse() * mass * 2) -- inferred equivalent call
				task.delay(0.1, function()
					part1.CanCollide = true
				end)
			end

			for k in pairs(self.ArmorPartsMap) do
				local v = k
				task.delay(5, function()
					local total = 0

					while total < 1.5 do
						total += task.wait()
						v.Transparency = total / 1.5
					end

					v:Destroy()
				end)
			end

			for _, armorRemoveInstance in pairs(self.ArmorRemoveInstances) do
				armorRemoveInstance:Destroy()
			end
		elseif p2 == "ShieldRemove" then
			self.Character:ToggleShieldIfExists(false)
		end
	elseif p == Enums.EnemyAbilities.EradicatorMK2ReworkDroneSupport and p2 == "Flare" then
		if self._Wrappers.OriginEffectWrapper then
			self._Wrappers.OriginEffectWrapper:PlayAll()
		end

		if self._Wrappers.FlareEffectWrapper then
			self._Wrappers.FlareEffectWrapper:PlayAll()
		end

		local flareOriginModel = self.FlareOriginModel
		local flareOriginPart = self.FlareOriginPart

		if flareOriginModel then
			self.Character:RegenerateProjectile(flareOriginModel, 3, 1)
		else
			warn("Missing FlareOriginModel")
		end

		if flareOriginPart then
			local cframe = flareOriginPart.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
			local lookVector = cframe.LookVector
			local currentFlareVelocity = 35 * (1 / lookVector.Unit.Y) * lookVector.Unit * createVector(-0.5, 1.5, -0.5)
			self.FlareProjectilePart.CFrame = cframe
			self.CurrentFlareVelocity = currentFlareVelocity
			self.TimeLeftForFlare = self.FlareDefaultTime
			self.FlareActive = true
		else
			warn("Missing FlareOriginPart")
		end
	end
end

function EradicatorMK2ReworkCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function EradicatorMK2ReworkCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	if flag or flag2 then
		return
	end

	self.Character:StopStealthShimmer()
	self.Character:ToggleShieldIfExists(false)

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Start()
	end
end

function EradicatorMK2ReworkCustomCodeClass:CharacterCleanedUp()
	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Destroy()
	end

	if self.FlareActive then
		self._Wrappers.FlareEffectWrapper:StopContinuous()
	end

	task.delay(self.FlareDefaultTime + 1, function()
		if self.FlareProjectilePart then
			self.FlareProjectilePart:Destroy()
		end
	end)
end

function EradicatorMK2ReworkCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function EradicatorMK2ReworkCustomCodeClass:_EnterDamagedState()
	self.DamagedWrapper:PlayAll()
	local config = self.Config
	local v = Utilities.TryGetInstanceFromPath(self.CharacterModel, config.FootstepEffectInstanceNames)

	if not v then
		warn("Missing footstep SFX parent")
		return
	end

	local footstep = v:FindFirstChild("Footstep")
	local footstepDamaged = v:FindFirstChild("FootstepDamaged")

	if footstep and footstepDamaged then
		footstep.SoundId = footstepDamaged.SoundId
	else
		warn("Missing footstep SFX")
	end
end

return EradicatorMK2ReworkCustomCodeClass