local createVector = vector.create
local ProjectileHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local NetworkingUtilities = require(common:WaitForChild("NetworkingUtilities"))
local HashGeneratorClass = require(common:WaitForChild("HashGeneratorClass"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local Utilities = require(common:WaitForChild("Utilities"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local parent = script.Parent
local enemyClass = parent:WaitForChild("EnemyClass")
local towerClass = parent:WaitForChild("TowerClass")
local pathEntityClass = parent:WaitForChild("PathEntityClass")
local mapEntityClass = parent:WaitForChild("MapEntityClass")
local ProjectileClass = require(script:WaitForChild("ProjectileClass"))
local event = NetworkingHandler.GetEvent("NewProjectiles")
local event2 = NetworkingHandler.GetEvent("DestroyProjectiles")
local TryReadChildValue = Utilities.TryReadChildValue
local v = HashGeneratorClass.New()
local v2 = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function GetOriginAndTargetEntities(data)
	local v3 = nil
	local v4 = nil
	local module = require(towerClass)
	local module2 = require(enemyClass)
	local module3 = require(pathEntityClass)
	local module4 = require(mapEntityClass)

	if data.OriginEntityClass == "Tower" then
		v3 = module.GetTower(data.OriginHash)
	elseif data.OriginEntityClass == "PathEntity" then
		v3 = module3.GetPathEntity(data.OriginHash)
	elseif data.OriginEntityClass == "MapEntity" then
		v3 = module4.GetMapEntity(data.OriginHash)
	elseif data.OriginEntityClass == "Enemy" then
		v3 = module2.GetEnemy(data.OriginHash)
	end

	if not data.TargetHash then
		return v3, v4
	end

	if data.TargetEntityClass == "Tower" then
		return v3, (module.GetTower(data.TargetHash))
	end

	if data.TargetEntityClass == "PathEntity" then
		return v3, (module3.GetPathEntity(data.TargetHash))
	end

	if data.TargetEntityClass == "MapEntity" then
		return v3, (module4.GetMapEntity(data.TargetHash))
	end

	if data.TargetEntityClass == "Enemy" then
		return v3, (module2.GetEnemy(data.TargetHash))
	else
		warn("Target entity class not recognized: " .. data.TargetEntityClass)
	end

	return v3, v4
end

local function GetProjectileGoalPosition(data, position: Vector3, player, forceTrackCharacter: boolean?)
	local projectileConfig = data.ProjectileConfig
	Vector3.new()
	local v3 = nil

	if data.OverrideGoalPosition then
		return data.OverrideGoalPosition, v3
	end

	if not player then
		warn("No goal position could be determined. No target entity or override goal position given.")
		return
	end

	local character = player.Character

	if forceTrackCharacter then
		return player:GetPosition(), character
	end

	local v4 = data.TargetEntityClass == "Enemy"
	local isAirUnit = player:GetIsAirUnit()
	local predictedPosition

	if v4 then
		predictedPosition = player:GetPredictedPosition(data.TimeToHit + (projectileConfig.AnimationTriggerTime or 0))
	else
		predictedPosition = player:GetPosition()
	end

	local characterModel = character:GetCharacterModel()
	local targetHeadInsteadOfGround = projectileConfig.TargetHeadInsteadOfGround
	local targetTorsoInsteadOfGround = projectileConfig.TargetTorsoInsteadOfGround
		or characterModel:GetAttribute("TargetTorsoInsteadOfRoot")
	local targetBoundsInsteadOfCenter = projectileConfig.TargetBoundsInsteadOfCenter
		or characterModel:GetAttribute("TargetTorsoBounds")
	local effectFollowPart = EntityUtilities.GetEffectFollowPart(
		character,
		targetHeadInsteadOfGround,
		not (targetTorsoInsteadOfGround or isAirUnit)
	)

	if v4 then
		local v5 = predictedPosition - player:GetPathPosition()
		local v6 = effectFollowPart.Position + v5

		if not targetBoundsInsteadOfCenter then
			return v6, v3
		end

		warn("Target torso bounds not implemented yet for enemies")
		return v6, v3
	else
		if isAirUnit then
			return effectFollowPart.Position, character
		end

		if targetBoundsInsteadOfCenter then
			return EntityUtilities.GetPointOnPartBounds(position, effectFollowPart), v3
		end

		return effectFollowPart.Position, v3
	end
end

local function GetProjectileOriginParts(projectileOrigins, modelName: string, burstIndex: number?)
	local primaryParts = {}
	local models = {}

	local function SearchForProjectileOriginModel(p: string)
		for _, model in pairs(projectileOrigins:GetChildren()) do
			local v3 = model.Name:split("___")[1]

			if not (model:IsA("Model") and v3 == p) then
				continue
			end

			if not model.PrimaryPart then
				error("Origin model in character model must have primary part set.")
			end

			table.insert(models, model)
			table.insert(primaryParts, model.PrimaryPart)
		end
	end

	if burstIndex then
		SearchForProjectileOriginModel(modelName .. tostring(burstIndex))
	end

	if not burstIndex or #primaryParts == 0 then
		SearchForProjectileOriginModel(modelName)
	end

	if not burstIndex and #primaryParts == 0 then
		SearchForProjectileOriginModel(modelName .. "1")
	end

	if #primaryParts ~= 0 then
		return primaryParts, models
	end

	if burstIndex then
		error(`Origin model with name {modelName .. tostring(burstIndex)} not found in character model {projectileOrigins:GetFullName()}`)
		return primaryParts, models
	else
		error(`Origin model with name {modelName} not found in character model {projectileOrigins:GetFullName()}`)
	end

	return primaryParts, models
end

local function GetProjectileOriginRegenerationData(projectileConfig, instance)
	if projectileConfig.RegenerationDelay and projectileConfig.RegenerationTime then
		return projectileConfig.RegenerationDelay, projectileConfig.RegenerationTime
	end

	local child = instance:FindFirstChild(projectileConfig.Name .. "RegenData")

	if child then
		return
			child:GetAttribute("RegenerationDelay") or TryReadChildValue(child, "RegenerationDelay", 0),
			child:GetAttribute("RegenerationTime") or TryReadChildValue(child, "RegenerationTime", 0)
	end

	return
		instance:GetAttribute("RegenerationDelay") or TryReadChildValue(instance, "RegenerationDelay", 0),
		instance:GetAttribute("RegenerationTime") or TryReadChildValue(instance, "RegenerationTime", 0)
end

local function CleanUpProjectile(object) -- 2 equivalent calls inferred from this helper
	local hash = object.Hash
	object:Cleanup()
	v2[hash] = nil
	v:Return(hash)
end

function ProjectileHandler.NewProjectile(data)
	local v3 = {}
	local projectileConfig = data.ProjectileConfig

	if projectileConfig.NoPhysicalProjectile then
		local name = projectileConfig.Name
		warn(`Attempt to create {name} projectile on client with NoPhysicalProjectile set to true`)
		return v3
	else
		local originEntityClass = data.OriginEntityClass
		local targetEntityClass = data.TargetEntityClass
		local v4 = originEntityClass == "Tower"
		local v5 = originEntityClass == "PathEntity"
		local v6 = originEntityClass == "MapEntity"
		local v7, v8 = GetOriginAndTargetEntities(data)
		local overrideOriginCFrame = data.OverrideOriginCFrame
		local customCharacterHandling = data.CustomCharacterHandling

		if not (v7 or customCharacterHandling) then
			return v3
		end

		local character = not customCharacterHandling and v7.Character
		local v9 = nil
		local v10 = nil
		local projectileSkinName = nil
		local skinModelData = data.SkinModelData

		if v4 then
			skinModelData = skinModelData or character:GetSkinModelData()
		end

		local v11 = nil

		if not overrideOriginCFrame then
			if data.OverrideOriginPart then
				v9 = { data.OverrideOriginPart }
			else
				local characterModel = character.CharacterModel
				local projectileOriginCountOverrides = characterModel:FindFirstChild("ProjectileOriginCountOverrides")
				local child = projectileOriginCountOverrides
					and projectileOriginCountOverrides:FindFirstChild(projectileConfig.Name)
				local v12 = child and Utilities.TryReadChildValue(child, "Value")
				local alternateProjectileOrigins = characterModel:GetAttribute("AlternateProjectileOrigins")
					or projectileConfig.AlternateProjectileOrigins
				local v13 = v12
					or characterModel:GetAttribute("ProjectileOriginCount")
					or projectileConfig.AlternateProjectileOriginCount
				local overrideBurstModulo = characterModel:GetAttribute("OverrideBurstModulo")
				local burstIndex = data.BurstIndex

				if not burstIndex and alternateProjectileOrigins then
					burstIndex = character:GetProjectilesFiredCount() % v13 + 1
				end

				if overrideBurstModulo then
					burstIndex = burstIndex and burstIndex % overrideBurstModulo + 1
				end

				local projectileOrigins = characterModel:FindFirstChild("ProjectileOrigins") or characterModel
				local modelName = projectileConfig.ModelName
				v9, v10 = GetProjectileOriginParts(projectileOrigins, modelName, burstIndex)

				if projectileConfig.FlyForwardsRadialSpread then
					local positions = {}

					for _, model in pairs(projectileOrigins:GetChildren()) do
						local v14 = model.Name:split("___")[1]

						if not (model:IsA("Model") and v14:sub(1, #modelName) == modelName and model.PrimaryPart) then
							continue
						end

						table.insert(positions, model.PrimaryPart.Position)
					end

					if #positions > 1 then
						local v14 = createVector(0, 0, 0)

						for _, v15 in ipairs(positions) do
							v14 += v15
						end

						v11 = v14 / #positions
					end
				end
			end
		end

		local position = overrideOriginCFrame and overrideOriginCFrame.Position or v9[1] and v9[1].Position

		if not position then
			warn("No approximate origin position found for projectile")
			return v3
		end

		local v12, v13 = GetProjectileGoalPosition(data, position, v8, data.ForceTrackCharacter)
		local v14 = v12

		if not v12 then
			return v3
		end

		if v10 then
			for _, v15 in pairs(v10) do
				local v16

				if projectileConfig.DelayProjectileEffectsUntilHoldingOver then
					v16 = projectileConfig.AnimationTriggerTime
				end

				character:ProjectileFired(v15, v16, data.NoOriginEffects, data.ProjectileSpeedMultiplier)
				local v17, v18 = GetProjectileOriginRegenerationData(projectileConfig, v15)

				if v17 ~= 0 then
					character:RegenerateProjectile(v15, (projectileConfig.AnimationTriggerTime or 0) + v17, v18)
				end

				projectileSkinName = v15:GetAttribute("ProjectileSkinName")
					or Utilities.TryReadChildValue(v15, "ProjectileSkinName", nil)
			end
		end

		if
			(projectileConfig.HitVarianceXZ or projectileConfig.HitVarianceY)
			and not (projectileConfig.SpawnsStaticEntity or projectileConfig.SpawnsAttachmentEntity)
		then
			v12 = ProjectileUtilities.RandomOffsetPosition(
				v14,
				projectileConfig.HitVarianceXZ,
				projectileConfig.HitVarianceY,
				projectileConfig.HitVarianceYOnlyDown
			)
		end

		if (v4 or v5 or v6 or data.ForceFaceTarget) and not customCharacterHandling then
			if data.FromTowerDefaultAttack then
				v7:TriggerAttackFromProjectileHandler(v12, data.TurretIndex)
			elseif data.FaceTarget and not projectileConfig.CharacterNoFaceTarget then
				local turretConfigs = projectileConfig.TurretConfigs

				if turretConfigs then
					v7:AimProjectileTurret(projectileConfig.Name, turretConfigs, v12)
				else
					v7:FacePosition(v12, data.TurretIndex)
				end
			end
		end

		local function NewProjectile(p)
			local v15 = v:Get()
			local unit = nil

			if v11 and p then
				local v16 = p.Position - v11

				if v16.Magnitude > 0.01 then
					unit = v16.Unit
				end
			end

			local v16 = ProjectileClass.New(
				v15,
				projectileConfig,
				data.TimeToHit,
				v12,
				DEFAULT_SPEED_MULTIPLIER,
				data.OverrideOriginCFrame,
				p,
				data.BurnEffectName,
				data.BurnEffectDuration,
				v4 and v7.LevelHandler:GetPathLevelString(),
				data.SpawnStaticEntityHash,
				data.SpawnAttachmentEntityHash,
				projectileSkinName,
				skinModelData,
				v13,
				data.ProjectileSpeedMultiplier,
				unit,
				data.TrackGoalPart
			)
			v2[v15] = v16
			table.insert(v3, v16)

			if v7 and v7.Character and v7.Character:StealthIsActive() then
				v16:MatchStealthShimmer(originEntityClass, v7.Character)
			end
		end

		if data.OverrideOriginCFrame then
			NewProjectile()
		else
			for i, v15 in ipairs(v9) do
				NewProjectile(v15)

				if v9[i + 1] then
					v12 = ProjectileUtilities.RandomOffsetPosition(
						v14,
						projectileConfig.HitVarianceXZ,
						projectileConfig.HitVarianceY,
						projectileConfig.HitVarianceYOnlyDown
					)
				end
			end
		end

		return v3
	end
end

function ProjectileHandler.FindProjectileWithStaticEntityHash(p: number)
	for _, v3 in pairs(v2) do
		if v3.SpawnStaticEntityHash == p then
			return v3
		end
	end
end

function ProjectileHandler.FindProjectileWithAttachmentEntityHash(p: number)
	for _, v3 in pairs(v2) do
		if v3.SpawnAttachmentEntityHash == p then
			return v3
		end
	end
end

function ProjectileHandler:Run()
	for _, v3 in pairs(v2) do
		v3:Run(self)

		if v3:CanCleanup() then
			CleanUpProjectile(v3) -- inferred equivalent call
		end
	end
end

function ProjectileHandler.SetSpeedMultiplier(p: number)
	for _, v3 in pairs(v2) do
		v3:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function ProjectileHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v3 in ipairs(list) do
			local decompressProjectileInitPacket = NetworkingUtilities.DecompressProjectileInitPacket(v3)
			local v4 = {
				OriginEntityClass = decompressProjectileInitPacket.OriginEntityClass,
				TargetEntityClass = decompressProjectileInitPacket.TargetEntityClass,
				OriginHash = decompressProjectileInitPacket.OriginHash,
				TargetHash = decompressProjectileInitPacket.TargetHash,
				TimeToHit = decompressProjectileInitPacket.TimeToHit,
				OverrideGoalPosition = decompressProjectileInitPacket.OverrideGoalPosition,
				FaceTarget = true,
				ProjectileConfig = ResourceManager.GetProjectileConfig(decompressProjectileInitPacket.Name),
				OverrideOriginPart = nil,
				BurstIndex = decompressProjectileInitPacket.BurstIndex,
				BurnEffectName = decompressProjectileInitPacket.BurnEffectName,
				BurnEffectDuration = decompressProjectileInitPacket.BurnEffectDuration,
				FromTowerDefaultAttack = decompressProjectileInitPacket.FromTowerDefaultAttack,
				SpawnStaticEntityHash = decompressProjectileInitPacket.SpawnStaticEntityHash,
				SpawnAttachmentEntityHash = decompressProjectileInitPacket.SpawnAttachmentEntityHash,
				TurretIndex = decompressProjectileInitPacket.TurretIndex,
				ProjectileSpeedMultiplier = decompressProjectileInitPacket.ProjectileSpeedMultiplier
			}
			ProjectileHandler.NewProjectile(v4)
		end
	end)
	event2:AttachCallback(function()
		for _, v3 in pairs(v2) do
			CleanUpProjectile(v3) -- inferred equivalent call
		end
	end)
end

return ProjectileHandler