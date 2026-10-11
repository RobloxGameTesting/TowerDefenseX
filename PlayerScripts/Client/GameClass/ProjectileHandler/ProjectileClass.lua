local createVector = vector.create
local ProjectileClass = {}
ProjectileClass.__index = ProjectileClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local ObjectPoolClass = require(common:WaitForChild("ObjectPoolClass"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local VisualEffectHandler = require(script.Parent.Parent:WaitForChild("VisualEffectHandler"))
local color = Color3.fromRGB(80, 80, 80)
local projectiles = workspace:WaitForChild("Game"):WaitForChild("Projectiles")
local v = nil
local v2 = nil

local function GetOscillationData(instance, useC: boolean)
	local oscillationData = instance:FindFirstChild("OscillationData")

	if not oscillationData then
		return
	end

	local result = {}

	for _, child in pairs(oscillationData:GetChildren()) do
		local weld = nil
		local weldPointer = child:FindFirstChild("WeldPointer")

		if weldPointer then
			if weldPointer:IsA("StringValue") then
				weld = Utilities.TryGetInstanceFromPath(instance, weldPointer.Value)
			elseif weldPointer:IsA("ObjectValue") then
				weld = weldPointer.Value
			end
		end

		local v3 = Utilities.TryReadChildValue(child, "C0AnglePerSecond", (Vector3.new()))
		local v4 = Utilities.TryReadChildValue(child, "C1AnglePerSecond", (Vector3.new()))

		if weld then
			if weld:IsA("Motor6D") then
				table.insert(result, {
					UseC0 = useC,
					Weld = weld,
					XTransform = v3.X + v4.X,
					YTransform = v3.Y + v4.Y,
					ZTransform = v3.Z + v4.Z
				})
			else
				warn("GetOscillationData: weld is not a Motor6D", weld:GetFullName())
			end
		else
			warn("GetOscillationData: weld not found")
		end
	end

	return result
end

function ProjectileClass.New(hash: number, projectileConfig, total: number, vector: Vector3, speedMultiplier: number, cframe: CFrame?, projectileOriginPart, burnEffectName: string?, burnEffectDuration: number?, p: string?, spawnStaticEntityHash: number?, spawnAttachmentEntityHash: number?, projectileSkinName: string, skinModelData, trackCharacter, value: number?, vector2: Vector3?, trackPart)
	if not (cframe or projectileOriginPart) then
		error("OriginCFrame or ProjectileOriginPart must be provided.")
	end

	local overridePathLevelString = projectileConfig.OverridePathLevelString or p

	if projectileConfig.VariableProjectileModel and not overridePathLevelString then
		warn("ProjectileConfig.VariableProjectileModel is true but PathLevelString is nil.")
	end

	local timeToCleanUp = math.max(
		spawnStaticEntityHash and 2 or 0,
		spawnAttachmentEntityHash and 0.3 or 0,
		projectileConfig.TimeToKeepAfterHit or 0
	)

	if projectileConfig.ClientsideTimeToHitVariance then
		total += math.random() * projectileConfig.ClientsideTimeToHitVariance
	end

	local v3 = {
		Name = projectileConfig.Name,
		ProjectileSkinName = projectileSkinName,
		SkinModelData = skinModelData,
		Hash = hash,
		GoalPosition = vector,
		TrackCharacter = trackCharacter,
		TrackPart = trackPart,
		TrackPartOffset = nil,
		RandomSeed = math.random(),
		VariableProjectileModel = projectileConfig.VariableProjectileModel,
		PathLevelString = projectileConfig.VariableProjectileModel and overridePathLevelString,
		ProjectileSpeedMultiplier = value or 1,
		ProjectileConfig = projectileConfig,
		SpiralData = projectileConfig.SpiralData,
		BurnEffectName = burnEffectName,
		BurnEffectDuration = burnEffectDuration,
		ProjectileEmitterWrapper = nil,
		ProjectileSoundWrapper = nil,
		TimeToHit = total,
		TotalTimeToHit = total,
		SpeedMultiplier = speedMultiplier,
		Holding = nil,
		HoldTimeRemaining = nil,
		EffectsDelayTimeRemaining = nil,
		DelayedEffectsPlayed = nil,
		HideProjectileDuringHoldTime = projectileConfig.HideProjectileDuringHoldTime,
		DelayProjectileEffectsUntilHoldingOver = projectileConfig.DelayProjectileEffectsUntilHoldingOver,
		ProjectileEffectsCustomDelay = projectileConfig.ProjectileEffectsCustomDelay,
		PathCalculated = false,
		Hit = false,
		AnimationController = nil,
		AnimationTrack = nil,
		AnimationTrackTimeScale = nil,
		SpawnStaticEntityHash = spawnStaticEntityHash,
		AdjustHeightForSpawningStaticEntity = projectileConfig.AdjustHeightForSpawningStaticEntity,
		SpawnAttachmentEntityHash = spawnAttachmentEntityHash,
		CleanupReady = false,
		TimeToCleanUp = timeToCleanUp,
		InstancesToMakeTransparent = {},
		InstancesToDisable = {},
		OriginalInstanceTransparencyMap = {},
		OriginalInstanceMeshIdToTextureIdMap = {},
		OriginalInstanceMeshIdToColorMap = {},
		OriginalInstanceMeshIdToSAMap = {},
		AddedSurfaceAppearances = nil,
		OriginIsEnemy = nil,
		Stealth = false,
		ProjectilePoolName = nil,
		ProjectileModel = nil,
		ProjectilePrimaryPart = nil,
		OriginCFrame = cframe,
		ProjectileOriginPart = projectileOriginPart,
		ArcMidpoint = nil,
		ArcFirstHalfProportion = nil,
		Arc = nil,
		ArcAngle = nil,
		PrioritizeGoalForArcMidpoint = nil,
		AlwaysFaceTravelDirection = nil,
		RotationOffset = nil,
		RotationsInAir = nil,
		FlyForwardsTime = projectileConfig.FlyForwardsTime,
		FlyForwardsExponent = projectileConfig.FlyForwardsExponent,
		FlyForwardsRotationOffset = projectileConfig.FlyForwardsRotationOffset,
		FlyForwardsTimeRemaining = nil,
		RadialSpreadDirection = vector2,
		ProgressExponential = projectileConfig.ProgressExponential,
		StartCFrame = nil,
		GoalCFrame = nil,
		GoalCFrameRotation = projectileConfig.GoalCFrameRotation,
		AdditionalRotationPerSecond = projectileConfig.AdditionalRotationPerSecond,
		AdditionalRotationPerSecondMultiplier = nil,
		PreviousCFrame = nil,
		CurrentCFrame = nil,
		CurrentSpiralAdjustment = Vector3.new(),
		FlyForwardsVector = nil,
		OscillationData = nil
	}
	setmetatable(v3, ProjectileClass)
	v3:_Initialize()
	return v3
end

function ProjectileClass.GetPrimaryPartCFrame(p)
	if p.AdjustHeightForSpawningStaticEntity then
		return p.ProjectilePrimaryPart.CFrame * CFrame.new(0, -p.ProjectilePrimaryPart.Size.Y / 2, 0)
	end

	return p.ProjectilePrimaryPart.CFrame
end

function ProjectileClass.GetOriginCFrame(p)
	return p.StartCFrame or p.ProjectilePrimaryPart.CFrame
end

function ProjectileClass:EntitySpawned()
	self.CleanupReady = true
end

function ProjectileClass.GetBurnEffectData(p)
	return p.BurnEffectName, p.BurnEffectDuration
end

function ProjectileClass.CanCleanup(p)
	return p.CleanupReady
end

function ProjectileClass:Cleanup()
	self.ProjectileEmitterWrapper:Reset()
	self.ProjectileSoundWrapper:Reset()

	if self.AnimationController then
		self.AnimationController:Destroy()
	end

	local originIsEnemy = self.OriginIsEnemy
	local stealth = self.Stealth

	for _, part in pairs(self.InstancesToMakeTransparent) do
		part.Transparency = self.OriginalInstanceTransparencyMap[part]

		if not stealth or originIsEnemy or not part:IsA("BasePart") then
			continue
		end

		part.Color = part:GetAttribute("OriginalColor")
		part.Material = part:GetAttribute("OriginalMaterial")

		if part:IsA("MeshPart") then
			part.TextureID = part:GetAttribute("OriginalTextureId")
		end

		local originalReflectance = part:GetAttribute("OriginalReflectance")

		if originalReflectance then
			part.Reflectance = originalReflectance
		end
	end

	for _, v3 in pairs(self.InstancesToDisable) do
		v3.Enabled = true
	end

	self:_TryRemoveColorSkin()

	if self.ProjectileSkinName then
		v2:Recycle(self.ProjectilePoolName, self.ProjectileModel)
	else
		v:Recycle(self.ProjectilePoolName, self.ProjectileModel)
	end
end

function ProjectileClass:_HoldingEnded()
	if self.HideProjectileDuringHoldTime then
		for _, v3 in pairs(self.InstancesToMakeTransparent) do
			v3.Transparency = self.OriginalInstanceTransparencyMap[v3]
		end

		for _, v3 in pairs(self.InstancesToDisable) do
			v3.Enabled = true
		end
	end

	if self.DelayProjectileEffectsUntilHoldingOver then
		self.ProjectileEmitterWrapper:PlayAll()
		self.ProjectileSoundWrapper:PlayAll()
	end
end

function ProjectileClass:Run(p: number)
	local v3 = p * self.ProjectileSpeedMultiplier
	local projectilePrimaryPart = self.ProjectilePrimaryPart
	local originCFrame = self.OriginCFrame or self.ProjectileOriginPart.CFrame

	if self.Hit then
		self.TimeToCleanUp = math.max(0, self.TimeToCleanUp - v3)

		if self.TimeToCleanUp <= 0 then
			self.CleanupReady = true
		end
	else
		self.HoldTimeRemaining = math.max(0, self.HoldTimeRemaining - v3)

		if self.EffectsDelayTimeRemaining and not self.DelayedEffectsPlayed then
			self.EffectsDelayTimeRemaining -= v3

			if self.EffectsDelayTimeRemaining <= 0 then
				self.ProjectileEmitterWrapper:PlayAll()
				self.ProjectileSoundWrapper:PlayAll()
				self.DelayedEffectsPlayed = true
			end
		end

		if projectilePrimaryPart then
			if self.HoldTimeRemaining <= 0 then
				if self.Holding then
					self:_HoldingEnded()
					self.Holding = false
				end

				self.TimeToHit = math.max(0, self.TimeToHit - v3)

				if not self.PathCalculated then
					self:_CalculateProjectilePath()
				end

				if self.TrackPart then
					self:_UpdateTrackedGoal()
				end

				local startCFrame = self.StartCFrame
				local goalCFrame = self.GoalCFrame
				local v4 = (self.TotalTimeToHit - self.TimeToHit) / self.TotalTimeToHit

				if self.ProgressExponential then
					v4 ^= self.ProgressExponential
				end

				local lerped = Utilities.Lerp(startCFrame.X, goalCFrame.X, v4)
				local lerped2 = Utilities.Lerp(startCFrame.Z, goalCFrame.Z, v4)
				local v5

				if self.Arc then
					v5 = self:_GetProjectileHeightForArc()
				else
					v5 = Utilities.Lerp(startCFrame.Y, goalCFrame.Y, v4)
				end

				local vector = Vector3.new(lerped, v5, lerped2)
				local flyForwardsTime = self.FlyForwardsTime

				if flyForwardsTime then
					self.FlyForwardsTimeRemaining = math.max(0, self.FlyForwardsTimeRemaining - v3)

					if self.FlyForwardsTimeRemaining > 0 then
						local v6 = v4 * self.FlyForwardsVector
						vector = vector:Lerp(
							startCFrame.Position + v6,
							(self.FlyForwardsTimeRemaining / flyForwardsTime) ^ (self.FlyForwardsExponent or 2)
						)
					end
				end

				local trackCharacter = self.TrackCharacter

				if trackCharacter then
					local position = trackCharacter:GetRealTorso().Position
					vector = vector:Lerp(startCFrame.Position:Lerp(position, v4), v4 ^ 2)
				end

				local cframe = CFrame.new(vector)
				local rotation

				if self.AlwaysFaceTravelDirection then
					local previousCFrame = self.PreviousCFrame

					if v3 == 0 then
						if self.TimeToHit == self.TotalTimeToHit then
							cframe = CFrame.new(originCFrame.Position)
							rotation = originCFrame.Rotation
						else
							rotation = projectilePrimaryPart.CFrame.Rotation
						end
					elseif startCFrame == previousCFrame then
						rotation = originCFrame.Rotation
					else
						local vector2 = vector - previousCFrame.Position
						local spiralData = self.SpiralData

						if spiralData then
							local v6 = spiralData.RotationsPerSecond * (6.283185307179586 * (self.TimeToHit + self.RandomSeed))
							local v7 = spiralData.MaximumRadius * math.sin(3.141592653589793 * v4)
							local unit = Vector3.new(1, 1, (-1 * vector2.X + -1 * vector2.Y) / vector2.Z).Unit
							local unit2 = vector2:Cross(unit).Unit
							local currentSpiralAdjustment = v7 * (math.cos(v6) * unit + math.sin(v6) * unit2)
							vector2 = vector + currentSpiralAdjustment - projectilePrimaryPart.Position
							self.CurrentSpiralAdjustment = currentSpiralAdjustment
						end

						rotation = CFrame.new(Vector3.new(), vector2) * self.RotationOffset
					end
				else
					local lerped3 = Vector3.new(startCFrame:ToOrientation()):Lerp(
						Vector3.new(goalCFrame:ToOrientation()),
						self.RotationsInAir * v4
					)
					rotation = CFrame.fromOrientation(lerped3.X, lerped3.Y, lerped3.Z)
				end

				local additionalRotationPerSecond = self.AdditionalRotationPerSecond

				if additionalRotationPerSecond then
					local lerped3 = Vector3.new():Lerp(
						(self.AdditionalRotationPerSecondMultiplier or 1) * additionalRotationPerSecond,
						self.TotalTimeToHit * v4
					)
					rotation *= CFrame.fromOrientation(lerped3.X, lerped3.Y, lerped3.Z)
				end

				if self.OscillationData then
					for _, v6 in pairs(self.OscillationData) do
						local cframe2 = CFrame.Angles(v3 * v6.XTransform, v3 * v6.YTransform, v3 * v6.ZTransform)

						if v6.UseC0 then
							v6.Weld.C0 *= cframe2
						else
							v6.Weld.Transform *= cframe2
						end
					end
				end

				self:_SetProjectileCFrame(cframe * rotation)
			else
				self:_SetProjectileCFrame(originCFrame)
			end
		end

		if self.TimeToHit <= 0 then
			self:_Hit()
		end
	end
end

function ProjectileClass:SpeedMultiplierChanged(speedMultiplier: number)
	local v3 = speedMultiplier * self.ProjectileSpeedMultiplier
	self.ProjectileEmitterWrapper:SpeedMultiplierChanged(v3)
	self.ProjectileSoundWrapper:SpeedMultiplierChanged(v3)

	if self.AnimationTrack then
		self.AnimationTrack:AdjustSpeed((self.AnimationTrackTimeScale or 1) * v3)
	end

	self.SpeedMultiplier = speedMultiplier
end

function ProjectileClass:MatchStealthShimmer(p: string, object)
	local originIsEnemy = p == "Enemy"
	self.OriginIsEnemy = originIsEnemy
	local currentStealthTransparency = object:GetCurrentStealthTransparency()

	for _, part in pairs(self.InstancesToMakeTransparent) do
		if self.OriginalInstanceTransparencyMap[part] < 0.4 then
			part.Transparency = currentStealthTransparency
		end

		if originIsEnemy or not part:IsA("BasePart") then
			continue
		end

		part:SetAttribute("OriginalColor", part.Color)
		part.Color = color
		part:SetAttribute("OriginalMaterial", part.Material)
		part.Material = Enum.Material.SmoothPlastic

		if part.Reflectance > 0 then
			part:SetAttribute("OriginalReflectance", part.Reflectance)
			part.Reflectance = 0
		end

		if not part:IsA("MeshPart") then
			continue
		end

		part:SetAttribute("OriginalTextureId", part.TextureID)
		part.TextureID = ""
	end

	self.Stealth = true
end

function ProjectileClass.StealthIsActive(p)
	return p.Stealth
end

function ProjectileClass.GetProjectileCFrame(p)
	return p.CurrentCFrame or p.ProjectilePrimaryPart.CFrame
end

function ProjectileClass:_SetProjectileCFrame(cframe: CFrame)
	self.PreviousCFrame = self.CurrentCFrame or self.ProjectilePrimaryPart.CFrame
	self.CurrentCFrame = cframe

	if self.SpiralData then
		self.ProjectilePrimaryPart.CFrame = cframe + self.CurrentSpiralAdjustment
	else
		self.ProjectilePrimaryPart.CFrame = cframe
	end
end

function ProjectileClass:_Hit()
	local projectileConfig = self.ProjectileConfig
	local name = not projectileConfig.NoOverrideExplosionEffect
		and Utilities.TryReadChildValue(self.ProjectileModel, "ExplosionEffectName")
		or projectileConfig.ExplosionEffectName
	local explosionEffectIsContinuous = projectileConfig.ExplosionEffectIsContinuous
	local explosionEffectEmitTime = projectileConfig.ExplosionEffectEmitTime

	if explosionEffectIsContinuous and not explosionEffectEmitTime then
		warn("Explosion effect continuous but emit time not set for projectile " .. projectileConfig.Name)
	end

	if projectileConfig and name then
		local v3 = {
			Name = name,
			Position = self.ProjectilePrimaryPart.Position,
			IsContinuous = explosionEffectIsContinuous,
			TimeToEmit = explosionEffectEmitTime,
			AdditionalSpeedMultiplier = self.ProjectileSpeedMultiplier
		}
		VisualEffectHandler.NewVisualEffect(v3)
	end

	self.ProjectileEmitterWrapper:StopContinuous()
	self.ProjectileSoundWrapper:StopContinuous()

	if not (self.SpawnStaticEntityHash or self.SpawnAttachmentEntityHash) then
		for _, v3 in pairs(self.InstancesToMakeTransparent) do
			v3.Transparency = 1
		end

		for _, v3 in pairs(self.InstancesToDisable) do
			v3.Enabled = false
		end
	end

	self.Hit = true
end

function ProjectileClass:_GetProjectileHeightForArc()
	local timeToHit = self.TimeToHit
	local totalTimeToHit = self.TotalTimeToHit
	local arcFirstHalfProportion = self.ArcFirstHalfProportion
	local y = self.StartCFrame.Y
	local y2 = self.GoalCFrame.Y
	local y3 = self.ArcMidpoint.Y
	local v3 = (totalTimeToHit - timeToHit) / totalTimeToHit
	local v4 = arcFirstHalfProportion * totalTimeToHit

	if v3 < arcFirstHalfProportion then
		local v5 = totalTimeToHit - timeToHit
		local v6 = 2 * (y3 - y) / v4
		local v7 = v6 / v4
		return y + v6 * v5 - v7 * v5 ^ 2 / 2
	else
		local v5 = totalTimeToHit - v4
		local v6 = totalTimeToHit - timeToHit - v4
		return y3 - 2 * (y3 - y2) / v5 ^ 2 * v6 ^ 2 / 2
	end
end

function ProjectileClass:_UpdateTrackedGoal()
	local goalPosition = self.TrackPart.Position + self.TrackPartOffset

	if goalPosition == self.GoalCFrame.Position then
		return
	end

	self.GoalPosition = goalPosition
	self.GoalCFrame = CFrame.new(goalPosition) * self.GoalCFrame.Rotation

	if self.Arc then
		self:_CalculateArcMidpoint()
	end
end

function ProjectileClass:_CalculateArcMidpoint()
	local position = self.StartCFrame.Position
	local position2 = self.GoalCFrame.Position

	if self.ArcAngle == 0 then
		self.ArcMidpoint = position
		self.ArcFirstHalfProportion = 0
	else
		local v3 = (position2 - position).Magnitude / 2 * math.tan(self.ArcAngle)
		local v4 = self.PrioritizeGoalForArcMidpoint and 0.75 or 0.5
		local vector = Vector3.new(
			position.X + v4 * (position2.X - position.X),
			math.max(position.Y, position2.Y) + v3,
			position.Z + v4 * (position2.Z - position.Z)
		)
		local magnitude = (vector - position).Magnitude
		local arcFirstHalfProportion = magnitude / (magnitude + (vector - position2).Magnitude)
		self.ArcMidpoint = vector
		self.ArcFirstHalfProportion = arcFirstHalfProportion
	end
end

function ProjectileClass:_CalculateRotationsPerSecond()
	local projectileConfig = self.ProjectileConfig

	if projectileConfig and not projectileConfig.AlwaysFaceTravelDirection then
		local rotationsInAirPerSecondMinimum = projectileConfig.RotationsInAirPerSecondMinimum
		local rotationsInAirPerSecondMaximum = projectileConfig.RotationsInAirPerSecondMaximum
		local v3

		if rotationsInAirPerSecondMinimum and rotationsInAirPerSecondMaximum then
			v3 = math.random(100 * rotationsInAirPerSecondMinimum, 100 * rotationsInAirPerSecondMaximum) / 100
		elseif rotationsInAirPerSecondMinimum then
			v3 = math.random(100 * rotationsInAirPerSecondMinimum, 100) / 100
		else
			v3 = not rotationsInAirPerSecondMaximum and 1
				or math.random(100, 100 * rotationsInAirPerSecondMaximum) / 100
		end

		self.RotationsInAir = v3 * self.TotalTimeToHit
	end
end

function ProjectileClass:_CalculateProjectilePath()
	local cframe = self.ProjectileModel.PrimaryPart.CFrame
	self.StartCFrame = cframe
	self.PreviousCFrame = cframe

	if self.GoalCFrameRotation then
		self.GoalCFrame *= self.GoalCFrameRotation
	else
		local orientation, v3, v4 = cframe:ToOrientation()
		local cframe2 = CFrame.fromOrientation(
			orientation + 1.5707963267948966,
			v3 + 1.5707963267948966,
			v4 + 1.5707963267948966
		)
		self.GoalCFrame *= cframe2
	end

	if self.Arc then
		self:_CalculateArcMidpoint()
	end

	self:_CalculateRotationsPerSecond()
	self.PathCalculated = true
end

function ProjectileClass:_Initialize()
	local projectileConfig = self.ProjectileConfig
	local modelName = projectileConfig.ModelName
	local originCFrame = self.OriginCFrame or self.ProjectileOriginPart.CFrame
	self.GoalCFrame = CFrame.new(self.GoalPosition)
	local projectileSkinName = self.ProjectileSkinName
	self.ProjectilePoolName = TowerUtilities.AppendPathLevelString(
		projectileSkinName or modelName,
		self.PathLevelString
	)
	local projectileModel

	if projectileSkinName then
		projectileModel = v2:Get(self.ProjectilePoolName)
	else
		projectileModel = v:Get(self.ProjectilePoolName)
	end

	if not projectileModel.PrimaryPart then
		error("Projectile model must have primary part set.")
	end

	projectileModel.PrimaryPart.Anchored = true
	projectileModel.PrimaryPart.CFrame = originCFrame
	projectileModel.Parent = projectiles
	self.ProjectilePrimaryPart = projectileModel.PrimaryPart
	self.ProjectileModel = projectileModel
	self:_TryApplyColorSkinData()

	if self.AdjustHeightForSpawningStaticEntity then
		self.GoalCFrame += Vector3.new(0, self.ProjectilePrimaryPart.Size.Y / 2, 0)
	end

	if self.TrackPart then
		self.TrackPartOffset = self.GoalCFrame.Position - self.TrackPart.Position
	end

	if projectileConfig.RandomizeAdditionalRotationPerSecond then
		self.AdditionalRotationPerSecondMultiplier = 1 + math.random()
	end

	for _, descendant in pairs(self.ProjectileModel:GetDescendants()) do
		if descendant:IsA("BasePart") or descendant:IsA("Decal") then
			table.insert(self.InstancesToMakeTransparent, descendant)
			self.OriginalInstanceTransparencyMap[descendant] = descendant.Transparency
		elseif descendant:IsA("Trail") then
			table.insert(self.InstancesToDisable, descendant)
		end
	end

	local finalSpeedMultiplier = self:_GetFinalSpeedMultiplier()
	self.ProjectileEmitterWrapper = WrapperFactory.NewEmitterWrapper(projectileModel, finalSpeedMultiplier)
	self.ProjectileSoundWrapper = WrapperFactory.NewSoundWrapper(self.ProjectilePrimaryPart, finalSpeedMultiplier)

	if projectileConfig.Arc then
		self.Arc = true
		self.ArcAngle = projectileConfig.ArcAngle or 0
		self.ArcAngle *= 0.017453292519943295
		self.PrioritizeGoalForArcMidpoint = projectileConfig.PrioritizeGoalForArcMidpoint
	end

	self.AlwaysFaceTravelDirection = projectileConfig.AlwaysFaceTravelDirection
	self.RotationOffset = projectileConfig.RotationOffset or CFrame.Angles(0, 0, 0)
	self.HoldTimeRemaining = projectileConfig.AnimationTriggerTime or 0

	if self.HoldTimeRemaining > 0 then
		self.Holding = true
	end

	if self.ProjectileEffectsCustomDelay then
		self.EffectsDelayTimeRemaining = self.ProjectileEffectsCustomDelay
	elseif not self.DelayProjectileEffectsUntilHoldingOver then
		self.ProjectileEmitterWrapper:PlayAll()
		self.ProjectileSoundWrapper:PlayAll()
	end

	self:_TryInitializeAnimation()
	self.OscillationData = GetOscillationData(projectileModel, self.AnimationTrack ~= nil)

	if self.HideProjectileDuringHoldTime then
		for _, v3 in pairs(self.InstancesToMakeTransparent) do
			v3.Transparency = 1
		end

		for _, v3 in pairs(self.InstancesToDisable) do
			v3.Enabled = false
		end
	end

	if self.FlyForwardsTime then
		self.FlyForwardsTimeRemaining = math.min(self.TimeToHit, self.FlyForwardsTime)
		local unit

		if self.FlyForwardsRotationOffset then
			unit = (originCFrame * self.FlyForwardsRotationOffset).LookVector.Unit
		else
			unit = originCFrame.LookVector.Unit
		end

		local flyForwardsOverrideVelocity = projectileConfig.FlyForwardsOverrideVelocity or projectileConfig.Velocity
		self.FlyForwardsVector = self.FlyForwardsTime * flyForwardsOverrideVelocity * unit

		if projectileConfig.FlyForwardsVectorOffset then
			self.FlyForwardsVector += projectileConfig.FlyForwardsVectorOffset
		end

		if self.RadialSpreadDirection and projectileConfig.FlyForwardsRadialSpread then
			local flyForwardsRadialSpread = math.rad(projectileConfig.FlyForwardsRadialSpread)
			local magnitude = self.FlyForwardsVector.Magnitude
			self.FlyForwardsVector = (self.RadialSpreadDirection * math.cos(flyForwardsRadialSpread) + createVector(0, 1, 0) * math.sin(flyForwardsRadialSpread)).Unit * magnitude
		end
	end
end

function ProjectileClass:_TryInitializeAnimation()
	local projectileModel = self.ProjectileModel
	local innerAnimationsModelName = self.ProjectileModel:GetAttribute("InnerAnimationsModelName")

	if innerAnimationsModelName then
		projectileModel = projectileModel:FindFirstChild(innerAnimationsModelName)

		if not projectileModel then
			warn("Projectile InnerAnimationsModelName not found for projectile " .. self.ProjectileConfig.Name)
			return
		end
	end

	local animation = projectileModel:FindFirstChildOfClass("Animation")

	if animation then
		local animationController = Instance.new("AnimationController", projectileModel)
		local track = Instance.new("Animator", animationController):LoadAnimation(animation)
		local timeScale = animation:GetAttribute("TimeScale") or 1
		track:Play(nil, nil, timeScale * self:_GetFinalSpeedMultiplier())
		self.AnimationController = animationController
		self.AnimationTrack = track
		self.AnimationTrackTimeScale = timeScale
	end
end

function ProjectileClass:_TryApplyColorSkinData()
	local skinModelData = self.SkinModelData

	if not skinModelData then
		return
	end

	local colorSkinMeshIdToTextureIdMap = skinModelData.ColorSkinMeshIdToTextureIdMap
	local colorSkinMeshIdToColorMap = skinModelData.ColorSkinMeshIdToColorMap
	local colorSkinMeshIdToSAMap = skinModelData.ColorSkinMeshIdToSAMap

	if not (colorSkinMeshIdToTextureIdMap and colorSkinMeshIdToColorMap) then
		return
	end

	local originalInstanceMeshIdToTextureIdMap = self.OriginalInstanceMeshIdToTextureIdMap
	local originalInstanceMeshIdToColorMap = self.OriginalInstanceMeshIdToColorMap
	local originalInstanceMeshIdToSAMap = self.OriginalInstanceMeshIdToSAMap
	local clones = nil

	for _, part in pairs(self.ProjectileModel:GetDescendants()) do
		if not part:IsA("MeshPart") then
			continue
		end

		local meshId = part.MeshId
		local v3

		if meshId:find("rbxassetid://") then
			v3 = string.match(meshId, "%d[%d.,]*")
		else
			v3 = string.match(meshId, "=%s*(%d[,.%d]*)")
		end

		local surfaceAppearance = part:FindFirstChildOfClass("SurfaceAppearance")
		local v4 = false
		local v5 = false

		if colorSkinMeshIdToSAMap then
			local v6 = colorSkinMeshIdToSAMap[v3]

			if v6 then
				local clone = v6:Clone()
				clone.Parent = part
				clones = clones or {}
				table.insert(clones, clone)
				originalInstanceMeshIdToTextureIdMap[part] = part.TextureID
				part.TextureID = ""
				v5 = true
				v4 = true
			end
		end

		if colorSkinMeshIdToTextureIdMap and not v5 then
			local textureID = colorSkinMeshIdToTextureIdMap[v3]

			if textureID then
				originalInstanceMeshIdToTextureIdMap[part] = part.TextureID
				part.TextureID = textureID
				v4 = true
			end
		end

		local color2 = colorSkinMeshIdToColorMap and colorSkinMeshIdToColorMap[v3]

		if color2 then
			originalInstanceMeshIdToColorMap[part] = part.Color
			part.Color = color2
		end

		if not (v4 and surfaceAppearance) then
			continue
		end

		originalInstanceMeshIdToSAMap[part] = surfaceAppearance
		surfaceAppearance.Parent = self.ProjectileModel
	end

	self.AddedSurfaceAppearances = clones
end

function ProjectileClass:_TryRemoveColorSkin()
	if not self.SkinModelData then
		return
	end

	for k, textureID in pairs(self.OriginalInstanceMeshIdToTextureIdMap) do
		k.TextureID = textureID
	end

	for k, color2 in pairs(self.OriginalInstanceMeshIdToColorMap) do
		k.Color = color2
	end

	for k, v3 in pairs(self.OriginalInstanceMeshIdToSAMap) do
		v3.Parent = k
	end

	if self.AddedSurfaceAppearances then
		for _, addedSurfaceAppearance in pairs(self.AddedSurfaceAppearances) do
			addedSurfaceAppearance:Destroy()
		end
	end
end

function ProjectileClass:_GetFinalSpeedMultiplier()
	return self.SpeedMultiplier * self.ProjectileSpeedMultiplier
end

v = ObjectPoolClass.New("ProjectilePool", ResourceManager.GetAllProjectileModels(), ResourceManager.GetProjectileModel)
v2 = ObjectPoolClass.New(
	"ProjectileSkinPool",
	ResourceManager.GetAllProjectileSkinModels(),
	ResourceManager.GetProjectileSkinModel
)
return ProjectileClass