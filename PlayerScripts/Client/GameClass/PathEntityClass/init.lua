local PathEntityClass = {}
PathEntityClass.__index = PathEntityClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("CustomCodeTypes"))
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local NetworkingUtilities = require(common:WaitForChild("NetworkingUtilities"))
require(common:WaitForChild("Utilities"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
require(common:WaitForChild("TowerBuffUtilities"))
local BaseClasses = script.Parent:WaitForChild("BaseClasses")
local CharacterClass = require(BaseClasses:WaitForChild("CharacterClass"))
local MovementHandlerClass = require(BaseClasses:WaitForChild("MovementHandlerClass"))
local TowerClass = require(script.Parent:WaitForChild("TowerClass"))
local EnemyClass = require(script.Parent:WaitForChild("EnemyClass"))
local ProjectileHandler = require(script.Parent:WaitForChild("ProjectileHandler"))
local VisualEffectHandler = require(script.Parent:WaitForChild("VisualEffectHandler"))
local HealthHandlerClass = require(script:WaitForChild("HealthHandlerClass"))
local BuffHandlerClass = require(script:WaitForChild("BuffHandlerClass"))
local AbilityHandlerClass = require(script:WaitForChild("AbilityHandlerClass"))
local event = NetworkingHandler.GetEvent("PathEntityFactoryQueueUpdated")
local event2 = NetworkingHandler.GetEvent("PathEntityHealthChanged1")
local event3 = NetworkingHandler.GetEvent("PathEntityHealthChanged2")
local event4 = NetworkingHandler.GetEvent("PathEntityAllDamageReductionChanged")
local event5 = NetworkingHandler.GetEvent("PathEntityMovementStateChanged")
local event6 = NetworkingHandler.GetEvent("PathEntityAnimationStateChanged")
local event7 = NetworkingHandler.GetEvent("PathEntityFaceGoalUntilMove")
local event8 = NetworkingHandler.GetEvent("PathEntityUsedAbility")
local event9 = NetworkingHandler.GetEvent("PathEntityApplyBuffData")
local event10 = NetworkingHandler.GetEvent("PathEntityRemoveBuffData")
local event11 = NetworkingHandler.GetEvent("PathEntityVisualEffect")
local v = {
	NetworkingHandler.GetEvent("PathEntityTargetChanged1"),
	NetworkingHandler.GetEvent("PathEntityTargetChanged2"),
	NetworkingHandler.GetEvent("PathEntityTargetChanged3"),
	NetworkingHandler.GetEvent("PathEntityTargetChanged4"),
	NetworkingHandler.GetEvent("PathEntityTargetChanged5")
}
local v2 = {
	NetworkingHandler.GetEvent("PathEntityConvertedTargetChanged1"),
	NetworkingHandler.GetEvent("PathEntityConvertedTargetChanged2"),
	NetworkingHandler.GetEvent("PathEntityConvertedTargetChanged3"),
	NetworkingHandler.GetEvent("PathEntityConvertedTargetChanged4"),
	NetworkingHandler.GetEvent("PathEntityConvertedTargetChanged5")
}
local v3 = {
	NetworkingHandler.GetEvent("PathEntityAttack1"),
	NetworkingHandler.GetEvent("PathEntityAttack2"),
	NetworkingHandler.GetEvent("PathEntityAttack3"),
	NetworkingHandler.GetEvent("PathEntityAttack4"),
	NetworkingHandler.GetEvent("PathEntityAttack5")
}
local v4 = {
	NetworkingHandler.GetEvent("PathEntityConvertedAttack1"),
	NetworkingHandler.GetEvent("PathEntityConvertedAttack2"),
	NetworkingHandler.GetEvent("PathEntityConvertedAttack3"),
	NetworkingHandler.GetEvent("PathEntityConvertedAttack4"),
	NetworkingHandler.GetEvent("PathEntityConvertedAttack5")
}
local v5 = {}
local v6 = {}
local v7 = 0
local pathEntities = workspace:WaitForChild("Game"):WaitForChild("PathEntities")
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function MakeAttackClientDataTable(pathEntityConfig)
	if not pathEntityConfig.HasAttack then
		return
	end

	local result = {}

	for i, v8 in ipairs(pathEntityConfig.AttackData) do
		local projectileName = v8.IsProjectile and v8.ProjectileName
		result[i] = {
			AimTime = v8.AimTime or 0,
			IsBurst = v8.IsBurst or false,
			BurstSize = v8.BurstSize,
			BurstInterval = v8.BurstInterval,
			IsPiercing = v8.IsPiercing,
			Range = v8.Range,
			ReloadTime = v8.ReloadTime,
			DamageDelay = v8.DamageDelay,
			NoAnimation = v8.NoAnimation,
			AttackIsProjectile = v8.IsProjectile,
			AttackProjectileConfig = projectileName and ResourceManager.GetProjectileConfig(projectileName),
			AttackAnimationSpeedMultiplier = 1,
			AttackBurstIndex = 1,
			TimeUntilResetAttackBurstIndex = 0,
			ClientHitEffectData = v8.ClientHitEffectData,
			CurrentTarget = nil,
			LatestAttackedTarget = nil,
			TimeSinceLastAttack = 1e999,
			CurrentTargetIsTower = false,
			TimeSinceLastHadTarget = 0
		}
	end

	return result
end

function PathEntityClass.New(list)
	assert(list, "InitData not provided")
	local hash = list[1]
	local v8 = list[2]
	local v9 = list[3]
	local skinName = list[4] or nil
	local pathLevelString = list[5]
	local v10 = list[6]
	local v11 = list[7]
	local stopped = list[8]
	local v12 = list[9]
	local state = list[10]
	local v13 = list[11]
	local summoned = list[12]
	local uniqueId = list[13]
	local v14 = list[14]
	local v15 = list[15]
	local v16 = list[16]
	local pvpTeamIndex = list[17] or nil
	local v17 = list[18]
	local v18 = list[19] or nil
	assert(hash, "Path entity hash not provided")
	assert(v9, "Path entity type not provided")
	assert(v10, "MovementInitData not provided")
	local pathEntityConfig = ResourceManager.GetPathEntityConfig(v9)
	assert(pathEntityConfig, "Path entity config not found for type " .. v9)
	local v19 = v5[hash]

	if v19 then
		v19:Destroy(true)
	end

	local v20 = ResourceManager.TryGetPathEntityClientCustomCodeClass(pathEntityConfig.OverrideCustomCodeName or v9)
	local customCode = v20 and v20.New(DEFAULT_SPEED_MULTIPLIER)

	if pathEntityConfig.HasCustomCode and not customCode then
		warn("PathEntity " .. v9 .. " has custom code but no custom code class was found")
	elseif not pathEntityConfig.HasCustomCode and customCode then
		warn("PathEntity " .. v9 .. " does not have custom code but a custom code class was found")
	end

	local hoverHeight = pathEntityConfig.HoverHeight
		or ResourceManager.GetPathEntityModelDerivedHoverHeight(pathEntityConfig.OverrideCharacterModelName or v9, v8)
	local movementHandler = MovementHandlerClass.New(
		hash,
		v10,
		summoned,
		hoverHeight,
		DEFAULT_SPEED_MULTIPLIER,
		nil,
		nil,
		stopped,
		pathEntityConfig,
		pvpTeamIndex
	)
	local v21 = {
		Hash = hash,
		Type = v9,
		SkinName = skinName,
		OverrideModelName = pathEntityConfig.OverrideModelName,
		EntityClass = "PathEntity",
		Config = pathEntityConfig,
		SpawnCFrame = movementHandler:GetRealCFrame(),
		Parent = pathEntities,
		Stealth = false,
		Summoned = summoned,
		Cloned = false,
		IsFakeEnemy = false,
		MoveAnimationSpeedMultiplier = movementHandler:GetAnimationSpeed(),
		TurretConfigs = pathEntityConfig.TurretConfigs
	}
	local character = CharacterClass.New(v21, nil, v8)
	local healthHandler = HealthHandlerClass.New(v11, v14)
	local buffHandler = BuffHandlerClass.New(character)
	local abilityHandler = pathEntityConfig.AbilityNames and AbilityHandlerClass.New(pathEntityConfig.AbilityNames)
	local v22 = pathEntityConfig.AttackData and pathEntityConfig.AttackData[1]
	local v23 = {
		UniqueId = uniqueId,
		Hash = hash,
		PVPTeamIndex = pvpTeamIndex,
		Type = v9,
		PathLevelString = pathLevelString,
		Config = pathEntityConfig,
		CustomCode = customCode,
		DisplayName = pathEntityConfig.OverrideDisplayName or v9,
		NoHoverTooltip = pathEntityConfig.NoHoverTooltip,
		StealthDetection = pathEntityConfig.StealthDetection,
		ClientsideAttackTargetPathPosition = pathEntityConfig.ClientsideAttackTargetPathPosition,
		ClientsideAttackTargetTorsoPosition = pathEntityConfig.ClientsideAttackTargetTorsoPosition,
		HasTurret = character:HasTurret(),
		HoverHeight = hoverHeight,
		IsBurning = false,
		Destroyed = false,
		IsAirUnit = false,
		AllDamageReduction = v17 or 0,
		NoRestartAttackAnimationIfPlaying = pathEntityConfig.NoRestartAttackAnimationIfPlaying,
		CanPlayAttackAnimationAgain = pathEntityConfig.CanPlayAttackAnimationAgain,
		StopToAttack = pathEntityConfig.StopToAttack,
		TUS_TroopDamageMultiplier = v15,
		TUS_TroopRangeMultiplier = v16,
		AttackClientDataTable = MakeAttackClientDataTable(pathEntityConfig),
		Range = v22 and v22.Range,
		State = state,
		Stunned = false,
		Stopped = stopped,
		CFrame = movementHandler:GetRealCFrame(),
		MovementHandler = movementHandler,
		HealthHandler = healthHandler,
		BuffHandler = buffHandler,
		AbilityHandler = abilityHandler,
		Character = character,
		UserInputHovered = false
	}

	if v23.Stopped and pathEntityConfig.SpawnAnimationTime then
		character:SetAnimationState("Spawn")
	else
		character:SetAnimationState("Move")
	end

	v5[v23.Hash] = v23
	v6[character:GetTorso()] = v23
	v7 += 1
	setmetatable(v23, PathEntityClass)

	if abilityHandler then
		abilityHandler:SetPathEntity(v23)

		if customCode then
			abilityHandler:SetCustomCode(customCode)
		end
	end

	if customCode then
		character:SetCustomCode(customCode)
		customCode:Initialize(v23, pathEntityConfig)
	end

	if v12 then
		for i, v24 in ipairs(v12) do
			v23:TargetChanged(i, v24)
		end
	end

	for _, v24 in pairs(v13) do
		v23:ApplyBuffData(v24)
	end

	if summoned and not pathEntityConfig.SummonedNoVFX then
		local v24 = {
			Name = v18 or pathEntityConfig.SummonedVFXName or Enums.VisualEffects.Dirt,
			Position = movementHandler:GetPosition()
		}
		VisualEffectHandler.NewVisualEffect(v24)
	end

	return v23
end

function PathEntityClass.SpawnExistingPathEntities(list)
	for _, v8 in ipairs(list) do
		if not v5[v8[1]] then
			PathEntityClass.New(v8)
		end
	end
end

function PathEntityClass.GetPathEntity(p: number)
	return v5[p]
end

function PathEntityClass.GetPathEntities()
	return v5
end

function PathEntityClass.GetPathEntityByTorso(p)
	return v6[p]
end

function PathEntityClass:SetSpeedMultiplier()
	DEFAULT_SPEED_MULTIPLIER = self

	for _, v8 in pairs(v5) do
		v8:SpeedMultiplierChanged(DEFAULT_SPEED_MULTIPLIER)
	end
end

function PathEntityClass.LogicLoop(p: number, p2: number)
	for _, v8 in pairs(v5) do
		v8:Logic(p, p2)
	end
end

function PathEntityClass:Logic(p: number, _: number)
	local movementHandler = self.MovementHandler
	local buffHandler = self.BuffHandler
	local character = self.Character
	local attackClientDataTable = self.AttackClientDataTable

	if attackClientDataTable then
		for _, v8 in pairs(attackClientDataTable) do
			v8.TimeSinceLastAttack += p

			if not v8.LatestAttackedTarget then
				continue
			end

			if v8.LatestAttackedTarget:Alive() then
				if v8.TimeSinceLastAttack >= v8.ReloadTime * 2 then
					v8.LatestAttackedTarget = nil
				end
			else
				v8.LatestAttackedTarget = nil
			end
		end
	end

	local v8 = attackClientDataTable and attackClientDataTable[1]
	local currentTarget = v8 and v8.CurrentTarget
	local latestAttackedTarget = v8 and v8.LatestAttackedTarget

	if buffHandler.BuffsChanged then
		local statMultipliers = buffHandler:GetStatMultipliers()
		self.Stunned = statMultipliers.Stunned
		local isOnFire = buffHandler:IsOnFire()

		if self.IsBurning or not isOnFire then
			if self.IsBurning and not isOnFire then
				self.Character:StopBurn()
				self.IsBurning = false
			end
		else
			self.Character:StartBurn()
			self.IsBurning = true
		end

		if attackClientDataTable then
			for _, v9 in pairs(attackClientDataTable) do
				v9.AttackAnimationSpeedMultiplier = math.max(1, 1 + statMultipliers.FirerateMultiplier)
			end
		end

		self:_AdjustAttackAnimationSpeed()
		buffHandler.BuffsChanged = false
	end

	movementHandler:Run(p, self.Stopped)

	if self.Stunned then
		self:SetAnimationState("Idle")
		self.CFrame = self.MovementHandler:GetRealCFrame()
		character:SetCFrame(self.CFrame)
	elseif self.Stopped then
		local aim = character.PrimaryAnimationHandler and character.PrimaryAnimationHandler.Animations.Aim

		if currentTarget and currentTarget:Alive() then
			if aim and self.State ~= "Aim" then
				self:SetAnimationState("Aim")
			end

			if v8 then
				if v8.CurrentTargetIsTower then
					self:FaceTower(1, currentTarget)
				else
					self:FaceEnemy(1, currentTarget)
				end

				v8.TimeSinceLastHadTarget = 0
			end
		elseif v8 then
			v8.TimeSinceLastHadTarget += p
			local timeSinceLastHadTarget = v8.TimeSinceLastHadTarget
			local aimTime = v8.AimTime

			if aim and aimTime <= timeSinceLastHadTarget and self.State == "Aim" then
				self:SetAnimationState("Idle")
			end
		end

		if self.HasTurret then
			character:SetCFrame(self.MovementHandler:GetRealCFrame())
		else
			local realCFrame = self.MovementHandler.ForceFaceOn and self.MovementHandler:GetRealCFrame() or self.CFrame

			if character:ShouldLerpRotation() then
				character:LerpCFrame(p, realCFrame, true)
			else
				character:SetCFrame(realCFrame, true)
			end
		end
	else
		if v8 then
			if self.StopToAttack then
				self:SetAnimationState("Move")
			elseif v8.TimeSinceLastAttack <= v8.ReloadTime then
				if self.State ~= "Attack" then
					local primaryAnimationHandler = self.Character.PrimaryAnimationHandler

					if primaryAnimationHandler and primaryAnimationHandler.Animations.Attack then
						self:SetAnimationState("Attack")
					end
				end
			else
				self:SetAnimationState("Move")
			end
		else
			self:SetAnimationState("Move")
		end

		self.CFrame = self.MovementHandler:GetRealCFrame()
		character:SetCFrame(self.CFrame)

		if latestAttackedTarget and self.HasTurret then
			if v8.CurrentTargetIsTower then
				self:FaceTower(1, latestAttackedTarget)
			else
				self:FaceEnemy(1, latestAttackedTarget)
			end
		end
	end

	character:SetParentCurrentMovementSpeed((self.Stopped or self.Stunned) and 0 or movementHandler:GetCurrentSpeed())
	character:Run(p)

	if attackClientDataTable then
		for _, v9 in pairs(attackClientDataTable) do
			if not v9.IsBurst then
				continue
			end

			v9.TimeUntilResetAttackBurstIndex -= p

			if v9.TimeUntilResetAttackBurstIndex <= 0 then
				v9.AttackBurstIndex = 1
			end
		end
	end

	if self.AbilityHandler then
		self.AbilityHandler:Run(p)
	end
end

function PathEntityClass:FacePositionUntilNextMove(vector: Vector3, p: number)
	self.MovementHandler:SetForceFacePosition(vector, p)
end

function PathEntityClass:GetPosition()
	return self.MovementHandler.RealCFrame.Position
end

function PathEntityClass:GetTorsoPosition()
	return self.Character:GetRealTorso().Position
end

function PathEntityClass:GetPathPosition()
	return self.MovementHandler:GetPathPosition()
end

function PathEntityClass:GetPredictedPosition(p: number)
	if self.Stopped then
		return self:GetPathPosition()
	end

	return self.MovementHandler:GetPredictedPosition(p)
end

function PathEntityClass:FacePosition(vector: Vector3, p: number)
	if self.HasTurret then
		self.Character:AimTurretAtPosition(vector, p)
		return
	end

	local position = self:GetPosition()
	local vector2 = Vector3.new(vector.X, position.Y, vector.Z)
	self.CFrame = CFrame.new(position, vector2)

	if not self.Character:ShouldLerpRotation() then
		self.Character:SetCFrame(self.CFrame, true)
	end
end

function PathEntityClass:FaceEnemy(p: number, object)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPathPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function PathEntityClass:FaceTower(p: number, object)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function PathEntityClass:SetAnimationState(state: string)
	self.State = state
	self.Character:SetAnimationState(state)
end

function PathEntityClass:SetStopped(stopped: boolean)
	self.Stopped = stopped

	if not stopped then
		self.MovementHandler:RemoveForceFacePosition()
	end
end

function PathEntityClass:SetHealthPercentage(p: number)
	local maxHealth = self.HealthHandler:GetMaxHealth()
	self.HealthHandler:SetHealth((math.ceil(maxHealth * p)))
end

function PathEntityClass:SetHealth(p: number)
	self.HealthHandler:SetHealth(p)
end

function PathEntityClass:AbilityUsed(p)
	if self.AbilityHandler then
		self.AbilityHandler:AbilityUsed(p)
	else
		warn("Path entity used ability but doesn't have ability handler")
	end
end

function PathEntityClass.FaceTurretToTarget(player, player2, value: number)
	if not player2 then
		warn("FaceTurretToTarget: Target entity not provided")
		return
	end

	if not value then
		warn("FaceTurretToTarget: Turret index not provided")
		return
	end

	if not player.HasTurret then
		warn(`FaceTurretToTarget: Enemy {player.Type} doesn't have turret`)
	end

	local position = player2.Character:GetRealTorso().Position
	player.Character:AimTurretAtPosition(position, value or 1)
end

function PathEntityClass:ApplyBuffData(p)
	self.BuffHandler:ApplyBuffData(p, not self.Destroyed)
end

function PathEntityClass:RemoveBuffData(p)
	self.BuffHandler:RemoveBuffData(p)
end

function PathEntityClass:_AdjustAttackAnimationSpeed()
	local attackClientDataTable = self.AttackClientDataTable
	local v8 = attackClientDataTable and attackClientDataTable[1]
	local v9 = false

	if v8 then
		local attackProjectileConfig = v8.AttackProjectileConfig
		v9 = attackProjectileConfig and attackProjectileConfig.AnimationTriggerTime and true or false
	end

	if v9 then
		self.Character:SetAttackAnimationSpeed(1)
	elseif v8 then
		self.Character:SetAttackAnimationSpeed(v8.AttackAnimationSpeedMultiplier)
	end
end

function PathEntityClass:_RenderProjectileForAttack(turretIndex: number, object, flag: boolean?)
	local attackClientDataTable = self.AttackClientDataTable
	local v8 = attackClientDataTable and attackClientDataTable[turretIndex]

	if not v8 then
		warn("No attack client data found for attack handler index " .. tostring(turretIndex))
		return
	end

	local attackProjectileConfig = v8.AttackProjectileConfig
	local position = object:GetPosition()

	if attackProjectileConfig.NoPhysicalProjectile then
		if flag then
			self:FaceTower(turretIndex, object)
		else
			self:FaceEnemy(turretIndex, object)
		end
	else
		local overrideGoalPosition = nil

		if v8.IsPiercing and not object:GetIsAirUnit() then
			local range = v8.Range
			local v9 = position - self.CFrame.Position

			if v9.Magnitude < range then
				overrideGoalPosition = self.CFrame.Position + range * v9.Unit
			end
		end

		local timeToHitForRangedProjectile = ProjectileUtilities.GetTimeToHitForRangedProjectile(
			self.CFrame.Position,
			overrideGoalPosition or position,
			attackProjectileConfig
		)
		local v9 = {
			OriginEntityClass = "PathEntity",
			TargetEntityClass = flag and "Tower" or "Enemy",
			OriginHash = self.Hash,
			TargetHash = object.Hash,
			TimeToHit = timeToHitForRangedProjectile,
			OverrideGoalPosition = overrideGoalPosition,
			FaceTarget = true,
			ProjectileConfig = attackProjectileConfig,
			BurstIndex = self:_GetAttackBurstIndex(turretIndex),
			TurretIndex = turretIndex
		}
		ProjectileHandler.NewProjectile(v9)
	end
end

function PathEntityClass:_HandleRenderHitEffect(p: number, object, vector: Vector3?)
	if not (object or vector) then
		warn("No goal position could be determined for rendering hit effect")
		return
	end

	local attackClientDataTable = self.AttackClientDataTable
	local v8 = attackClientDataTable and attackClientDataTable[p]
	local clientHitEffectData = v8 and v8.ClientHitEffectData

	if not clientHitEffectData then
		return
	end

	if v8.AttackIsProjectile then
		warn("Projectile with ClientHitEffectData detected. Set hit effects in the projectile instead")
		return
	end

	local v9 = vector
		or clientHitEffectData.TargetTorsoInsteadOfGround and object:GetTorsoPosition()
		or object:GetPosition()
	local randomOffsetPosition = ProjectileUtilities.RandomOffsetPosition(
		v9,
		clientHitEffectData.VarianceXZ,
		clientHitEffectData.VarianceY,
		clientHitEffectData.VarianceYOnlyDown
	)
	local v10 = {
		Name = self.Character:GetOverrideHitEffectName() or clientHitEffectData.EffectName,
		Position = randomOffsetPosition,
		Delay = clientHitEffectData.Delay or v8.DamageDelay
	}
	VisualEffectHandler.NewVisualEffect(v10)
end

function PathEntityClass:Attack(p: number, latestAttackedTarget, flag: boolean?)
	local attackClientDataTable = self.AttackClientDataTable
	local v8 = attackClientDataTable and attackClientDataTable[p]

	if not v8 then
		return
	end

	if v8.AttackIsProjectile then
		self:_RenderProjectileForAttack(p, latestAttackedTarget, flag)
	elseif flag then
		self:FaceTower(p, latestAttackedTarget)
	else
		self:FaceEnemy(p, latestAttackedTarget)
	end

	v8.LatestAttackedTarget = latestAttackedTarget
	v8.TimeSinceLastAttack = 0
	v8.CurrentTargetIsTower = flag or false
	self.MovementHandler:RemoveForceFacePosition()
	self:_Attacked(p)
	self:_HandleRenderHitEffect(p, latestAttackedTarget)
end

function PathEntityClass:_Attacked(p: number)
	local character = self.Character
	local primaryAnimationHandler = self.Character.PrimaryAnimationHandler
	local attack = primaryAnimationHandler and primaryAnimationHandler.Animations.Attack
	local v8 = self.AttackClientDataTable and self.AttackClientDataTable[p]

	if attack then
		local flag = false

		if not v8.NoAnimation then
			if self.NoRestartAttackAnimationIfPlaying and primaryAnimationHandler:GetState() == attack.Name then
				if self.CanPlayAttackAnimationAgain then
					attack:SetPlayAgainWhenFinished()
				end
			else
				flag = true
			end
		end

		if flag then
			self:SetAnimationState("Attack")
		end
	end

	character:Attacked(self:_GetAttackBurstIndex(p), p)
	self:_BurstAttackHandling(p)
end

function PathEntityClass:_GetAttackBurstIndex(p: number)
	local attackClientDataTable = self.AttackClientDataTable
	local v8 = attackClientDataTable and attackClientDataTable[p]
	return v8 and v8.IsBurst and v8.AttackBurstIndex
end

function PathEntityClass:_BurstAttackHandling(p: number)
	local attackClientDataTable = self.AttackClientDataTable
	local v8 = attackClientDataTable and attackClientDataTable[p]

	if v8 and v8.IsBurst then
		v8.AttackBurstIndex += 1

		if v8.AttackBurstIndex > v8.BurstSize then
			v8.AttackBurstIndex = 1
		end

		v8.TimeUntilResetAttackBurstIndex = 2 * v8.BurstInterval
	end
end

function PathEntityClass:TargetChanged(p: number, p2: number, flag: boolean?)
	local attackClientDataTable = self.AttackClientDataTable
	local v8 = attackClientDataTable and attackClientDataTable[p]

	if not v8 then
		return
	end

	if p2 == 0 then
		v8.CurrentTarget = nil
		return
	end

	local currentTarget = flag and TowerClass.GetTower(p2) or EnemyClass.GetEnemy(p2)

	if not currentTarget then
		warn(`PathEntity TargetChanged: {flag and "Tower" or "Enemy"} doesn't exist`)
		return
	end

	v8.CurrentTarget = currentTarget
	v8.CurrentTargetIsTower = flag or false
end

function PathEntityClass:GetIsAirUnit()
	return self.IsAirUnit
end

function PathEntityClass:Alive()
	return not self.Destroyed
end

function PathEntityClass.IsDestroyed(p)
	return p.Destroyed
end

function PathEntityClass:Destroy(flag: boolean?, flag2: boolean?)
	self.Destroyed = true

	if self.AbilityHandler then
		self.AbilityHandler:Destroy()
	end

	if self.CustomCode then
		self.CustomCode:PathEntityDestroyed(flag, flag2)
	end

	self.BuffHandler:RemoveAllBuffs()
	self.MovementHandler:Destroy()
	self.Character:SetParentCurrentMovementSpeed(0)
	self.Character:SetFadeOutOnDeath(not flag)
	self.Character:Destroy(flag)
	v5[self.Hash] = nil
	v6[self.Character:GetTorso()] = nil
	v7 -= 1
end

function PathEntityClass:SpeedMultiplierChanged(p: number)
	self.Character:SetSpeedMultiplier(p)

	if self.AbilityHandler then
		self.AbilityHandler:SetSpeedMultiplier(p)
	end
end

function PathEntityClass.GetCurrentRange(data)
	local statMultipliers = data.BuffHandler:GetStatMultipliers()
	local v8 = data.TUS_TroopRangeMultiplier * data.Range
	local v9 = (1 + statMultipliers.RangeMultiplier) * v8
	return v9, v9 < v8
end

function PathEntityClass.Initialize()
	event:AttachCallback(function(items)
		for _, item in pairs(items) do
			if item.Creation then
				PathEntityClass.New(item.Data)
			else
				local data = item.Data
				local hash = data.Hash
				local endReached = data.EndReached
				local immediate = data.Immediate
				local v8 = v5[hash]

				if v8 then
					v8:Destroy(immediate, endReached)
				else
					print("Didn't find path entity to remove")
					print(hash)
				end
			end
		end
	end)
	event2:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndPercentage, v8 = NetworkingUtilities.DecompressHashAndPercentage(item)
			local v9 = v5[decompressHashAndPercentage]

			if v9 then
				v9:SetHealthPercentage(v8)
			end
		end
	end)
	event3:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v8 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v9 = v5[decompressHashAndInteger]

			if v9 then
				v9:SetHealth(v8)
			end
		end
	end)
	event4:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v8 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v9 = v5[decompressHashAndInteger]

			if v9 then
				v9.AllDamageReduction = v8 / 100000
			end
		end
	end)
	event5:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v8 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v9 = v8 == 1
			local v10 = v5[decompressHashAndInteger]

			if v10 then
				v10:SetStopped(v9)
			end
		end
	end)

	for i = 1, #v do
		local v8 = i
		v[i]:AttachCallback(function(list)
			for _, v9 in ipairs(list) do
				local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
				local v11 = v5[decompressDoubleHash]

				if v11 then
					v11:TargetChanged(v8, v10)
				else
					print("PathEntity TargetChangedEvent: PathEntity doesn't exist")
					print(decompressDoubleHash)
					break
				end
			end
		end)
	end

	for i = 1, #v2 do
		local v8 = i
		v2[i]:AttachCallback(function(list)
			for _, v9 in ipairs(list) do
				local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
				local v11 = v5[decompressDoubleHash]

				if v11 then
					v11:TargetChanged(v8, v10, true)
				else
					print("PathEntity ConvertedTargetChangedEvent: PathEntity doesn't exist")
					break
				end
			end
		end)
	end

	for i = 1, #v3 do
		local v8 = i
		v3[i]:AttachCallback(function(list)
			for _, v9 in ipairs(list) do
				local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
				local v11 = v5[decompressDoubleHash]
				local enemy = EnemyClass.GetEnemy(v10)

				if not v11 then
					print("PathEntity AttackEvent: PathEntity doesn't exist")
					break
				end

				if enemy then
					v11:Attack(v8, enemy)
				else
					print("PathEntity AttackEvent: Enemy doesn't exist")
					break
				end
			end
		end)
	end

	for i = 1, #v4 do
		local v8 = i
		v4[i]:AttachCallback(function(list)
			for _, v9 in ipairs(list) do
				local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
				local v11 = v5[decompressDoubleHash]
				local tower = TowerClass.GetTower(v10)

				if not v11 then
					print("PathEntity ConvertedAttackEvent: PathEntity doesn't exist")
					break
				end

				if tower then
					v11:Attack(v8, tower, true)
				else
					print("PathEntity ConvertedAttackEvent: Tower doesn't exist")
					break
				end
			end
		end)
	end

	event7:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v8 = item[1]
			local v9 = item[2]
			local v10 = item[3]
			local v11 = v5[v8]

			if v11 then
				v11:FacePositionUntilNextMove(v9, v10)
			end
		end
	end)
	event6:AttachCallback(function(list)
		for _, v8 in ipairs(list) do
			local v9 = v8[1]
			local v10 = v8[2]
			local v11 = v5[v9]

			if v11 then
				v11:SetAnimationState(v10)
			else
				print("PathEntity AnimationStateChangedEvent: PathEntity doesn't exist")
				break
			end
		end
	end)
	event8:AttachCallback(function(list)
		local v8 = list[1]
		local v9 = list[2]
		local v10 = v5[v8]

		if v10 then
			v10:AbilityUsed(v9)
		end
	end)
	event9:AttachCallback(function(items)
		for _, item in pairs(items) do
			local towerHash = item.TowerHash
			local v8 = v5[towerHash]

			if v8 then
				v8:ApplyBuffData(item)
			else
				print("Didn't find path entity with hash " .. tostring(towerHash) .. " to apply buff data to")
			end
		end
	end)
	event10:AttachCallback(function(items)
		for _, item in pairs(items) do
			local towerHash = item.TowerHash
			local v8 = v5[towerHash]

			if v8 then
				v8:RemoveBuffData(item)
			else
				print("Didn't find path entity with hash " .. tostring(towerHash) .. " to remove buff data from")
			end
		end
	end)
	event11:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v8 = item[1]
			local v9 = item[2]
			local v10 = v5[v8]

			if v10 then
				VisualEffectHandler.HandleVisualEffectOnEntity(v10.Character, v9)
			else
				print("PathEntityVisualEffectEvent: PathEntity doesn't exist")
				break
			end
		end
	end)
end

return PathEntityClass