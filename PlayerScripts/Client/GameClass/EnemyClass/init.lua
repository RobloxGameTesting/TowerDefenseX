local EnemyClass = {}
EnemyClass.__index = EnemyClass

function EnemyClass.__tostring(data)
	return `Enemy Type: {data.Type} Hash: {data.Hash} UniqueId: {data.UniqueId}`
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("CustomCodeTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
local EnemyBuffUtilities = require(common:WaitForChild("EnemyBuffUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local NetworkingUtilities = require(common:WaitForChild("NetworkingUtilities"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local EnemyUtilities = require(common:WaitForChild("EnemyUtilities"))
local TeamUtilities = require(common:WaitForChild("TeamUtilities"))
local parent = script.Parent
local parent2 = parent.Parent
local towerClass = parent:WaitForChild("TowerClass")
local pathEntityClass = parent:WaitForChild("PathEntityClass")
local mapEntityClass = parent:WaitForChild("MapEntityClass")
local UserInterfaceHandler = require(parent2:WaitForChild("UserInterfaceHandler"))
local BaseClasses = script.Parent:WaitForChild("BaseClasses")
local CharacterClass = require(BaseClasses:WaitForChild("CharacterClass"))
local MovementHandlerClass = require(BaseClasses:WaitForChild("MovementHandlerClass"))
local VisualEffectHandler = require(script.Parent:WaitForChild("VisualEffectHandler"))
local AmbienceHandler = require(script.Parent:WaitForChild("AmbienceHandler"))
local PlayerEffectHandler = require(script.Parent:WaitForChild("PlayerEffectHandler"))
local ProjectileHandler = require(script.Parent:WaitForChild("ProjectileHandler"))
local DropCoinsHandler = require(script.Parent:WaitForChild("DropCoinsHandler"))
local HealthHandlerClass = require(script:WaitForChild("HealthHandlerClass"))
local BurnHandlerClass = require(script:WaitForChild("BurnHandlerClass"))
local BuffHandlerClass = require(script:WaitForChild("BuffHandlerClass"))
local AbilityHandlerClass = require(script:WaitForChild("AbilityHandlerClass"))
local ValentinesCardHandler = require(script:WaitForChild("ValentinesCardHandler"))
local BountyDisplayHandlerClass = require(script:WaitForChild("BountyDisplayHandlerClass"))
local isStudio = RunService:IsStudio()
local KNOCKBACK_TWEEN_TIME = _G.KNOCKBACK_TWEEN_TIME
local event = NetworkingHandler.GetEvent("EnemyFactoryQueueUpdated")
local event2 = NetworkingHandler.GetEvent("EnemiesSpeedChanged")
local event3 = NetworkingHandler.GetEvent("EnemiesDefaultSpeedChanged")
local event4 = NetworkingHandler.GetEvent("EnemiesTopSpeedMultiplierChanged")
local event5 = NetworkingHandler.GetEvent("EnemiesMaxHealthChanged")
local event6 = NetworkingHandler.GetEvent("EnemiesHealthChanged1")
local event7 = NetworkingHandler.GetEvent("EnemiesHealthChanged2")
local event8 = NetworkingHandler.GetEvent("EnemiesMaxShieldChanged")
local event9 = NetworkingHandler.GetEvent("EnemiesShieldChanged1")
local event10 = NetworkingHandler.GetEvent("EnemiesShieldChanged2")
local event11 = NetworkingHandler.GetEvent("EnemiesBodyHeatPercentChanged")
local event12 = NetworkingHandler.GetEvent("EnemiesBurningUpdate")
local event13 = NetworkingHandler.GetEvent("EnemyMovementStateChanged")
local event14 = NetworkingHandler.GetEvent("EnemyAnimationStateChanged")
local event15 = NetworkingHandler.GetEvent("EnemyFaceGoalUntilMove")
local event16 = NetworkingHandler.GetEvent("EnemyUsedAbility")
local event17 = NetworkingHandler.GetEvent("EnemyAbilityInterrupted")
local event18 = NetworkingHandler.GetEvent("EnemiesStealthStatusChanged")
local event19 = NetworkingHandler.GetEvent("EnemiesStunnedStatusChanged")
local event20 = NetworkingHandler.GetEvent("EnemiesExtraDamageChanged")
local event21 = NetworkingHandler.GetEvent("EnemyApplyBuffData")
local event22 = NetworkingHandler.GetEvent("EnemyRemoveBuffData")
local event23 = NetworkingHandler.GetEvent("EnemyRefreshBuffData")
local event24 = NetworkingHandler.GetEvent("EnemiesSecondLifeActivated")
local event25 = NetworkingHandler.GetEvent("EnemyStasisChanged")
local event26 = NetworkingHandler.GetEvent("EnemyTeleported")
local event27 = NetworkingHandler.GetEvent("EnemyKnockedBack")
local event28 = NetworkingHandler.GetEvent("EnemyBountyChanged")
local event29 = NetworkingHandler.GetEvent("EnemyInvulnerableChanged")
local event30 = NetworkingHandler.GetEvent("EnemyTakeNoDamageChanged")
local event31 = NetworkingHandler.GetEvent("EnemyMaximumDamageChanged")
local event32 = NetworkingHandler.GetEvent("EnemyAirUnitChanged")
local event33 = NetworkingHandler.GetEvent("EnemyAllDamageReductionChanged")
local event34 = NetworkingHandler.GetEvent("EnemyDamageResistanceModifierChanged")
local event35 = BindableHandler.GetEvent("BossCountChanged")
local event36 = BindableHandler.GetEvent("WaveChanged")
local v = {
	NetworkingHandler.GetEvent("EnemyTargetChanged1"),
	NetworkingHandler.GetEvent("EnemyTargetChanged2"),
	NetworkingHandler.GetEvent("EnemyTargetChanged3"),
	NetworkingHandler.GetEvent("EnemyTargetChanged4"),
	NetworkingHandler.GetEvent("EnemyTargetChanged5")
}
local v2 = {
	NetworkingHandler.GetEvent("EnemyAttack1"),
	NetworkingHandler.GetEvent("EnemyAttack2"),
	NetworkingHandler.GetEvent("EnemyAttack3"),
	NetworkingHandler.GetEvent("EnemyAttack4"),
	NetworkingHandler.GetEvent("EnemyAttack5")
}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = {}
local enemies = workspace:WaitForChild("Game"):WaitForChild("Enemies")
local v7 = 0
local v8 = 0
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER
local v9 = nil

local function AttachPVPSentMarker(player)
	if player.PVPTeamIndex ~= TeamUtilities.GetLocalPlayerTeamIndex() then
		return
	end

	local head = player.Character:GetHead()

	if not head then
		return
	end

	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "PVPSentMarker"
	billboardGui.Adornee = head
	billboardGui.Size = UDim2.new(0, 50, 0, 50)
	billboardGui.StudsOffset = Vector3.new(0, head.Size.Y / 2 + 1.5, 0)
	billboardGui.AlwaysOnTop = true
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.BackgroundTransparency = 1
	imageLabel.Size = UDim2.new(1, 0, 1, 0)
	imageLabel.Image = "rbxassetid://139267096632314"
	imageLabel.ImageColor3 = Color3.fromRGB(255, 0, 0)
	imageLabel.Parent = billboardGui
	billboardGui.Parent = head
end

local function GetStatOverrideMap(p) -- 2 equivalent calls inferred from this helper
	local difficultyToStatOverrideMap = p.DifficultyToStatOverrideMap
	return difficultyToStatOverrideMap and difficultyToStatOverrideMap[v9]
end

local function GetDisplayName(p: string, enemyConfig, flag: boolean) -- 1 equivalent call inferred from this helper
	local statOverrideMap = GetStatOverrideMap(enemyConfig) -- inferred equivalent call
	local v10

	if statOverrideMap then
		v10 = statOverrideMap.OverrideDisplayName
	end

	local v11 = v10 or enemyConfig.OverrideDisplayName or p

	if flag then
		return v11 .. " CLONED"
	end

	return v11
end

local function GetBossMusicName(enemyConfig) -- 1 equivalent call inferred from this helper
	local statOverrideMap = GetStatOverrideMap(enemyConfig) -- inferred equivalent call
	return statOverrideMap and statOverrideMap.OverrideBossMusicName or enemyConfig.BossMusicName
end

local function MakeAttackClientDataTable(enemyConfig)
	if not enemyConfig.HasAttack then
		return
	end

	local result = {}

	for i, v10 in ipairs(enemyConfig.AttackData) do
		local projectileName = v10.IsProjectile and v10.ProjectileName
		result[i] = {
			IgnoreOnClient = v10.IgnoreOnClient,
			AimTime = v10.AimTime or 0,
			IsBurst = v10.IsBurst or false,
			BurstSize = v10.BurstSize,
			BurstInterval = v10.BurstInterval,
			IsPiercing = v10.IsPiercing,
			Range = v10.Range,
			ReloadTime = v10.ReloadTime,
			DamageDelay = v10.DamageDelay,
			AttackIsProjectile = v10.IsProjectile,
			AttackProjectileConfig = projectileName and ResourceManager.GetProjectileConfig(projectileName),
			AttackAnimationSpeedMultiplier = 1,
			AttackBurstIndex = 1,
			TimeUntilResetAttackBurstIndex = 0,
			ClientHitEffectData = v10.ClientHitEffectData,
			TriggerDefaultBeamEffect = v10.TriggerDefaultBeamEffect,
			CurrentTarget = nil,
			LatestAttackedTarget = nil,
			TimeSinceLastAttack = 1e999,
			CurrentTargetIsPathEntity = false,
			CurrentTargetIsMapEntity = false,
			TimeSinceLastHadTarget = 0
		}
	end

	return result
end

function EnemyClass.New(list)
	assert(list, "InitData not provided")
	local hash = list[1]
	local randomHash = list[2]
	local v10 = list[3]
	local stealth = list[4]
	local stopped = list[5]
	local summoned = list[6]
	local cloned = list[7]
	local v11 = list[8]
	local v12 = list[9]
	local v13 = list[10]
	local bodyHeatPercentage = list[11]
	local noCash = list[12]
	local stunned = list[13]
	local v14 = list[14]
	local v15 = list[15]
	local _ = list[16]
	local damageMultiplier = list[17]
	local extraDamageMultiplier = list[18]
	local v16 = list[19]
	local onSecondLife = list[20]
	local inStasis = list[21]
	local stasisCFrame = list[22]
	local v17 = list[23]
	local uniqueId = list[24]
	local invulnerable = list[25]
	local takeNoDamage = list[26]
	local maximumDamage = list[27]
	local v18 = list[28]
	local stealthDetection = list[29]
	local damageResistanceModifier = list[30]
	local allDamageReduction = list[31]
	local pvpTeamIndex = list[32] or nil
	local v19 = list[33] or nil
	assert(hash, "Enemy hash not provided")
	assert(v10, "Enemy type not provided")
	assert(v11, "MovementInitData not provided")
	local v20 = v3[hash]
	local serverSpawnTime = v11[6]

	if v20 then
		if not isStudio then
			print("Enemy already exists:", v20.Type, hash)
		end

		if v20.ServerSpawnTime == serverSpawnTime then
			if not isStudio then
				print("-> Same spawn time:", serverSpawnTime)
			end

			return
		else
			if not isStudio then
				print("-> Different spawn time:", v20.ServerSpawnTime, "v.s.", serverSpawnTime)
				print("-> Destroyed", v20.Type)
			end

			v20:Destroy(true)
		end
	end

	local enemyConfig = ResourceManager.GetEnemyConfig(v10)
	assert(enemyConfig, "Enemy config not found for type " .. v10)
	local v21 = ResourceManager.TryGetEnemyClientCustomCodeClass(enemyConfig.OverrideCustomCodeName or v10)
	local customCode = v21 and v21.New(DEFAULT_SPEED_MULTIPLIER)

	if enemyConfig.HasCustomCode and not customCode then
		warn("Enemy " .. v10 .. " has custom code but no custom code class was found")
	elseif not enemyConfig.HasCustomCode and customCode then
		warn("Enemy " .. v10 .. " does not have custom code but a custom code class was found")
	end

	local airUnit = enemyConfig.AirUnit
	local hoverHeight = enemyConfig.HoverHeight
		or ResourceManager.GetEnemyModelDerivedHoverHeight(enemyConfig.OverrideCharacterModelName or v10, randomHash)
	local movementHandler = MovementHandlerClass.New(
		hash,
		v11,
		summoned,
		hoverHeight,
		DEFAULT_SPEED_MULTIPLIER,
		enemyConfig.ForceFaceIntroTime,
		enemyConfig.ForceFaceOutroTime,
		stopped,
		enemyConfig,
		pvpTeamIndex
	)
	local v22 = {
		Hash = hash,
		Type = v10,
		EntityClass = "Enemy",
		Config = enemyConfig,
		SpawnCFrame = movementHandler:GetRealCFrame(),
		Parent = enemies,
		Stealth = stealth,
		Summoned = summoned,
		Cloned = cloned,
		IsFakeEnemy = enemyConfig.FakeEnemy,
		MoveAnimationSpeedMultiplier = movementHandler:GetAnimationSpeed(),
		TurretConfigs = enemyConfig.TurretConfigs,
		NoSpawnTween = inStasis or v18
	}
	local character = CharacterClass.New(v22, nil, randomHash)
	local healthHandler = HealthHandlerClass.New(v12, v13, v14, v15)
	local burnHandler = BurnHandlerClass.New(character)
	local bountyDisplayHandler = BountyDisplayHandlerClass.New(
		enemyConfig.IsBoss,
		enemyConfig.IsMiniBoss,
		character,
		v17
	)
	local abilityHandler = (enemyConfig.AbilityNames or enemyConfig.DeathAbilityNames)
		and AbilityHandlerClass.New(enemyConfig.AbilityNames, enemyConfig.DeathAbilityNames, v9)
	local buffHandler = BuffHandlerClass.New(character, airUnit, enemyConfig.IsBoss or enemyConfig.IsMiniBoss)
	local v23 = enemyConfig.AttackData and enemyConfig.AttackData[1]
	local v24 = {
		UniqueId = uniqueId,
		Hash = hash,
		RandomHash = randomHash,
		PVPTeamIndex = pvpTeamIndex,
		Type = v10,
		ServerSpawnTime = serverSpawnTime,
		CustomCode = customCode,
		NoStealthName = enemyConfig.NoStealthName,
		DisplayName = GetDisplayName(v10, enemyConfig, cloned), -- inferred equivalent call
		NoHoverTooltip = enemyConfig.NoHoverTooltip,
		DamageReductionTable = enemyConfig.DamageReductionTable,
		DamageResistanceModifier = damageResistanceModifier,
		AllDamageReduction = allDamageReduction,
		IsFakeEnemy = enemyConfig.FakeEnemy,
		Untargetable = enemyConfig.Untargetable or false,
		IsBoss = enemyConfig.IsBoss,
		IsMiniBoss = enemyConfig.IsMiniBoss,
		BossMusicName = GetBossMusicName(enemyConfig), -- inferred equivalent call
		BossMusicDelayRemaining = enemyConfig.BossMusicDelay or 0,
		BossMusicPriorityMultiplier = enemyConfig.BossMusicPriorityMultiplier or 1,
		NoBossHPBar = enemyConfig.NoBossHPBar,
		BossHPBarColor = enemyConfig.BossHPBarColor,
		HeadshotImage = enemyConfig.HeadshotImage,
		HoverHeight = character:GetDefaultHoverHeight(),
		IsAlive = true,
		Frozen = false,
		Cloned = cloned,
		BodyHeatPercentage = bodyHeatPercentage,
		NoCash = noCash,
		DamageMultiplier = damageMultiplier,
		ExtraDamageMultiplier = extraDamageMultiplier,
		HasTurret = character:HasTurret(),
		StealthDetection = stealthDetection,
		ClientsideAttackTargetPathPosition = enemyConfig.ClientsideAttackTargetPathPosition,
		ClientsideAttackTargetTorsoPosition = enemyConfig.ClientsideAttackTargetTorsoPosition,
		IsAirUnit = airUnit,
		IsGhostlyUnit = enemyConfig.GhostlyUnit,
		NoRestartAttackAnimationIfPlaying = enemyConfig.NoRestartAttackAnimationIfPlaying,
		CanPlayAttackAnimationAgain = enemyConfig.CanPlayAttackAnimationAgain,
		UsePrimaryAttackDataForClient = enemyConfig.UsePrimaryAttackDataForClient,
		ToggleShieldModelIfHasShield = enemyConfig.ToggleShieldModelIfHasShield,
		NoAdjustMovementAnimationSpeed = enemyConfig.NoAdjustMovementAnimationSpeed,
		DamageReductionMap = EnemyUtilities.CreateDamageReductionMap(enemyConfig.DamageReductionTable),
		MaximumDamage = maximumDamage,
		IgnoreAdditionalSpeedMultiplier = enemyConfig.IgnoreAdditionalSpeedMultiplier,
		PreventDeathUntilAbilityExecuted = enemyConfig.PreventDeathUntilAbilityExecuted,
		AttackClientDataTable = MakeAttackClientDataTable(enemyConfig),
		Range = v23 and v23.Range,
		OnSecondLife = onSecondLife,
		SecondLifeData = enemyConfig.SecondLifeData,
		KnockbackActive = false,
		KnockbackTimeLeft = 0,
		KnockbackStart = nil,
		KnockbackGoalPathPercentage = 0,
		Stealth = stealth,
		ActiveStuns = {},
		Stunned = stunned,
		Stopped = stopped,
		CFrame = movementHandler:GetRealCFrame(),
		Invulnerable = invulnerable,
		TakeNoDamage = takeNoDamage,
		InStasis = inStasis,
		UnstasisStarted = false,
		UnstasisTimeLeft = enemyConfig.UnstasisTime,
		UnstasisTotalTime = enemyConfig.UnstasisTime,
		UnstasisAnimationName = enemyConfig.UnstasisAnimationName,
		UnstasisNoHoverTooltip = enemyConfig.UnstasisNoHoverTooltip,
		StasisCFrame = stasisCFrame,
		Character = character,
		MovementHandler = movementHandler,
		HealthHandler = healthHandler,
		BurnHandler = burnHandler,
		BountyDisplayHandler = bountyDisplayHandler,
		BuffHandler = buffHandler,
		AbilityHandler = abilityHandler,
		ShieldBreakDebounceTimeLeft = 0,
		KillShotDeboucenceTimeLeft = 0,
		UserInputHovered = false
	}
	v3[hash] = v24
	v4[v24.UniqueId] = v24
	v5[character:GetTorso()] = v24
	setmetatable(v24, EnemyClass)

	if abilityHandler then
		abilityHandler:SetEnemy(v24)

		if customCode then
			abilityHandler:SetCustomCode(customCode)
		end
	end

	if customCode then
		character:SetCustomCode(customCode)
		customCode:Initialize(v24, enemyConfig)
	end

	if not v24.IsFakeEnemy then
		if v24.Stopped and enemyConfig.SpawnAnimationTime then
			v24:SetAnimationState("Spawn")
		else
			v24:SetAnimationState("Move")
		end

		v7 += 1
	end

	for _, v25 in pairs(v16) do
		v24:ApplyBuffData(v25)
	end

	if v24.IsBoss or v24.IsMiniBoss then
		if not v24.NoBossHPBar then
			UserInterfaceHandler.AddBoss(v24)
		end

		v8 += 1
		event35:Fire(v8)
	end

	if summoned and not enemyConfig.SummonedNoVFX then
		local v25 = {
			Name = v19 or enemyConfig.SummonedVFXName or Enums.VisualEffects.Dirt,
			Position = movementHandler:GetPosition()
		}
		VisualEffectHandler.NewVisualEffect(v25)
	end

	if onSecondLife then
		v24:SecondLifeActivated()
	end

	if stealth then
		character:RunStealthShimmer()
	else
		character:StopStealthShimmer()
	end

	if enemyConfig.PreloadEnemies then
		CharacterClass.PreloadEnemies(enemyConfig.PreloadEnemies)
	end

	local v25 = v6[hash]

	if not v25 then
		return v24
	end

	v6[hash] = nil
	v24.SenderName = v25.SenderName
	v24.SenderUserId = v25.SenderUserId
	AttachPVPSentMarker(v24)
	return v24
end

function EnemyClass.SpawnExistingEnemies(list)
	for _, v10 in ipairs(list) do
		if not v3[v10[1]] then
			EnemyClass.New(v10)
		end
	end
end

function EnemyClass.GetEnemy(p)
	return v3[p]
end

function EnemyClass.GetEnemyByUniqueId(p: number)
	return v4[p]
end

function EnemyClass.GetEnemies()
	return v3
end

function EnemyClass.GetEnemyByTorso(p)
	return v5[p]
end

function EnemyClass.GetCount()
	return v7
end

function EnemyClass:SetSpeedMultiplier(p: number)
	DEFAULT_SPEED_MULTIPLIER = self

	for _, v10 in pairs(v3) do
		v10:SpeedMultiplierChanged(p)
	end
end

local function ShouldAutoPreloadEnemy(p: string)
	local enemyConfig = ResourceManager.FindEnemyConfig(p)

	if enemyConfig then
		return enemyConfig.IsBoss or enemyConfig.IsMiniBoss or enemyConfig.SpawnAnimationTime ~= nil
	end

	return false
end

function EnemyClass.PreloadEnemiesForWave(p: number)
	if not v9 then
		return
	end

	local waveConfig = ResourceManager.GetWaveConfig(v9)
	local v10 = waveConfig and waveConfig.Waves[p]

	if not v10 then
		return
	end

	local v11 = {}
	local enemyTypes = {}

	for _, spawnSequence in ipairs(v10.SpawnSequences) do
		local enemyType = spawnSequence.EnemyType

		if v11[enemyType] then
			continue
		end

		local enemyConfig = ResourceManager.FindEnemyConfig(enemyType)
		local v12

		if enemyConfig then
			v12 = enemyConfig.IsBoss or enemyConfig.IsMiniBoss or enemyConfig.SpawnAnimationTime ~= nil
		else
			v12 = false
		end

		if not v12 then
			continue
		end

		v11[enemyType] = true
		table.insert(enemyTypes, enemyType)
	end

	if #enemyTypes > 0 then
		task.spawn(CharacterClass.PreloadEnemies, enemyTypes)
	end
end

function EnemyClass.SetDifficulty(p: string)
	v9 = p
	EnemyClass.PreloadEnemiesForWave(1)
	local waveConfig = ResourceManager.GetWaveConfig(p)

	if waveConfig and waveConfig.PreloadEnemyNames then
		CharacterClass.PreloadEnemies(waveConfig.PreloadEnemyNames)
	end
end

function EnemyClass.Restart()
	ValentinesCardHandler.Restart()
end

function EnemyClass.LogicLoop(p: number, p2: number)
	debug.profilebegin("Enemy Logic")

	for _, v10 in pairs(v3) do
		v10:Logic(p, p2)
	end

	ValentinesCardHandler.LogicLoop(p)
	debug.profileend()
end

function EnemyClass:Logic(p: number, p2: number)
	if self.IgnoreAdditionalSpeedMultiplier then
		p = p2
	end

	local buffHandler = self.BuffHandler
	local burnHandler = self.BurnHandler
	local bountyDisplayHandler = self.BountyDisplayHandler
	local movementHandler = self.MovementHandler
	local character = self.Character
	local primaryAnimationHandler = character.PrimaryAnimationHandler
	local attackClientDataTable = self.AttackClientDataTable

	if attackClientDataTable then
		for _, v10 in pairs(attackClientDataTable) do
			v10.TimeSinceLastAttack += p

			if not v10.LatestAttackedTarget then
				continue
			end

			if v10.LatestAttackedTarget:Alive() then
				if v10.TimeSinceLastAttack >= v10.ReloadTime * 2 then
					v10.LatestAttackedTarget = nil
				end
			else
				v10.LatestAttackedTarget = nil
			end
		end
	end

	local v10 = attackClientDataTable and attackClientDataTable[1]
	local currentTarget = v10 and v10.CurrentTarget
	local latestAttackedTarget = v10 and v10.LatestAttackedTarget

	if buffHandler.BuffsChanged then
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

		self:_HandleOverlayPartState()
		character:SetOverrideMovementAnimation(buffHandler:GetOverrideMovementAnimationName())
		buffHandler.BuffsChanged = false
	end

	movementHandler:Run(p, self.Stopped)
	burnHandler:Run(p)
	bountyDisplayHandler:Run(p)

	if self.BossMusicDelayRemaining > 0 then
		self.BossMusicDelayRemaining -= p

		if self.BossMusicDelayRemaining <= 0 and (self.IsBoss or self.IsMiniBoss) then
			UserInterfaceHandler.RefreshBossInfo()
		end
	end

	if self.InStasis then
		if self.UnstasisStarted then
			local unstasisTimeLeft = self.UnstasisTimeLeft
			local unstasisTotalTime = self.UnstasisTotalTime

			if self.UnstasisTimeLeft <= 0 then
				self.InStasis = false

				if self.IsBoss or self.IsMiniBoss then
					UserInterfaceHandler.RefreshBossInfo()
				end
			else
				local v11 = (1 - unstasisTimeLeft / unstasisTotalTime) ^ 2.6
				local stasisCFrame = self.StasisCFrame
				local torsoToRootOffsets, v12 = character:GetTorsoToRootOffsets()
				local v13 = stasisCFrame + torsoToRootOffsets

				if v12 then
					v13 *= v12
				end

				character:LerpCFrame(p, (v13:Lerp(movementHandler:GetRealCFrame(), v11)))
			end

			self.UnstasisTimeLeft -= p
		else
			if primaryAnimationHandler and primaryAnimationHandler.Animations.Idle then
				self:SetAnimationState("Idle")
			end

			character:SetCFrameUsingRoot(self.StasisCFrame)
		end
	elseif self.Stopped then
		local aim = primaryAnimationHandler and primaryAnimationHandler.Animations.Aim

		if currentTarget and currentTarget:Alive() then
			if aim and self.State ~= "Aim" then
				self:SetAnimationState("Aim")
			end

			if v10 then
				if v10.CurrentTargetIsPathEntity then
					self:FaceEnemy(1, currentTarget)
				elseif v10.CurrentTargetIsMapEntity then
					self:FaceMapEntity(1, currentTarget)
				else
					self:FaceTower(1, currentTarget)
				end

				v10.TimeSinceLastHadTarget = 0
			end
		elseif v10 then
			v10.TimeSinceLastHadTarget += p
			local timeSinceLastHadTarget = v10.TimeSinceLastHadTarget
			local aimTime = v10.AimTime

			if aim and aimTime <= timeSinceLastHadTarget and self.State == "Aim" then
				self:SetAnimationState("Idle")
			end
		end

		if self.HasTurret then
			character:SetCFrame(self.MovementHandler:GetRealCFrame())
		else
			local realCFrame = self.MovementHandler.ForceFaceOn and self.MovementHandler:GetRealCFrame() or self.CFrame

			if self:_ShouldLerpRotation() then
				character:LerpCFrame(p, realCFrame, true)
			else
				character:SetCFrame(realCFrame, true)
			end
		end
	else
		if self.Type == Enums.Enemies.GiantFlameBot or self.Type == Enums.Enemies.FlameBot then
			if v10 and not (latestAttackedTarget and latestAttackedTarget:Alive()) then
				self:SetAnimationState("Move")
			end
		elseif v10 then
			self:SetAnimationState("Move")
		end

		self.CFrame = self.MovementHandler:GetRealCFrame()

		if self:_ShouldLerpRotation() then
			character:LerpCFrame(p, self.CFrame, true)
		else
			character:SetCFrame(self.CFrame, true)
		end

		if latestAttackedTarget and self.HasTurret then
			if v10.CurrentTargetIsPathEntity then
				self:FaceEnemy(1, latestAttackedTarget)
			elseif v10.CurrentTargetIsMapEntity then
				self:FaceMapEntity(1, latestAttackedTarget)
			else
				self:FaceTower(1, latestAttackedTarget)
			end
		end
	end

	character:SetStunned(self.ActiveStuns)
	character:SetTakingExtraDamage(self.ExtraDamageMultiplier > 1)

	if self.ToggleShieldModelIfHasShield then
		character:ToggleShieldIfExists(self.HealthHandler:IsShieldActive())
	end

	character:Run(p)

	if self.Stealth then
		character:RunStealthShimmer()
	else
		character:StopStealthShimmer()
	end

	if self.AbilityHandler then
		self.AbilityHandler:Run(p)
	end

	if self.BodyHeatPercentage <= 0 then
		self:_SetFrozen(true)
	else
		self:_SetFrozen(false)
	end

	if self.KnockbackActive then
		self:_RunKnockbackLogic(p)
	end

	if attackClientDataTable then
		for _, v11 in pairs(attackClientDataTable) do
			if not v11.IsBurst then
				continue
			end

			v11.TimeUntilResetAttackBurstIndex -= p

			if v11.TimeUntilResetAttackBurstIndex <= 0 then
				v11.AttackBurstIndex = 1
			end
		end
	end

	self.ShieldBreakDebounceTimeLeft = math.max(0, self.ShieldBreakDebounceTimeLeft - p)
	self.KillShotDeboucenceTimeLeft = math.max(0, self.KillShotDeboucenceTimeLeft - p)
end

function EnemyClass:FacePositionUntilNextMove(vector: Vector3, p: number)
	self.MovementHandler:SetForceFacePosition(vector, p)
end

function EnemyClass:GetPosition()
	return self.MovementHandler.RealCFrame.Position
end

function EnemyClass:GetTorsoPosition()
	return self.Character:GetRealTorso().Position
end

function EnemyClass:GetPathPosition()
	return self.MovementHandler:GetPathPosition()
end

function EnemyClass:GetPredictedPosition(p: number)
	if self.Stopped then
		return self:GetPathPosition()
	end

	return self.MovementHandler:GetPredictedPosition(p)
end

function EnemyClass:_ShouldLerpRotation()
	return self.AttackClientDataTable ~= nil or self.Character:ShouldLerpRotation()
end

function EnemyClass:FacePosition(vector: Vector3, p: number)
	if self.HasTurret then
		self.Character:AimTurretAtPosition(vector, p)
		return
	end

	local position = self:GetPosition()
	local vector2 = Vector3.new(vector.X, position.Y, vector.Z)
	self.CFrame = CFrame.new(position, vector2)

	if not self:_ShouldLerpRotation() then
		self.Character:SetCFrame(self.CFrame, true)
	end
end

function EnemyClass:FaceMapEntity(p: number, object)
	if object:GetAttackerShouldFaceMovementDirection() then
		self.CFrame = self.MovementHandler:GetRealCFrame()

		if not self:_ShouldLerpRotation() then
			self.Character:SetCFrame(self.CFrame, true)
		end
	elseif self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function EnemyClass:FaceEnemy(p: number, object)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPathPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function EnemyClass:FaceTower(p: number, object)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function EnemyClass:SetAnimationState(state: string)
	if
		self.IsFakeEnemy
		or state == "Move" and self.AbilityHandler and self.AbilityHandler:HasActiveContinuousAnimation()
	then
		return
	end

	self.State = state
	self.Character:SetAnimationState(state)
end

function EnemyClass:SetStopped(stopped: boolean)
	self.Stopped = stopped

	if not stopped then
		self.Character:OverrideDefaultAnimationState("Move")
		self.MovementHandler:RemoveForceFacePosition()
	end
end

function EnemyClass:Destroy(flag: boolean?, flag2: boolean?, data)
	if self.KnockbackSuspendVFX then
		self.KnockbackSuspendVFX:StopEarly(true)
		self.KnockbackSuspendVFX = nil
	end

	PlayerEffectHandler.StopEffectsForEnemy(self.Hash)
	AmbienceHandler.EnemyKilled(self.Type, self.Cloned)

	if data then
		if data.DropValentinesCard then
			ValentinesCardHandler.DropCard(self.Type, self:GetPosition())
		end

		if data.DropCoins then
			local v10 = { StartPosition = self:GetTorsoPosition(), StartVFX = true }
			DropCoinsHandler.DropCoins(v10)
		end

		if data.KilledFromVehicleCollision then
			local v10 = {
				Name = Enums.VisualEffects.VehicleCollisionHit,
				Position = self:GetPosition()
			}
			VisualEffectHandler.NewVisualEffect(v10)
		end
	end

	self.BuffHandler:RemoveAllBuffs()
	self.MovementHandler:Destroy()
	self.BurnHandler:Stop()
	self.BountyDisplayHandler:Destroy(flag, flag2)

	if self.IsBoss or self.IsMiniBoss then
		if not self.NoBossHPBar then
			UserInterfaceHandler.RemoveBoss(self, not (flag or flag2))
		end

		v8 -= 1
		event35:Fire(v8)
	end

	if self.AbilityHandler then
		self.AbilityHandler:Destroy()
	end

	if self.CustomCode then
		self.CustomCode:EnemyDestroyed(flag, flag2)
	end

	v5[self.Character:GetTorso()] = nil
	self.Character:Destroy(flag, flag2)
	v3[self.Hash] = nil
	v4[self.UniqueId] = nil

	if not self.IsFakeEnemy then
		v7 -= 1
	end

	self.IsAlive = false
end

function EnemyClass:Alive()
	return self.IsAlive
end

function EnemyClass:SetBossMusicName(bossMusicName: string?)
	if self.BossMusicName == bossMusicName then
		return
	end

	self.BossMusicName = bossMusicName

	if self.IsBoss or self.IsMiniBoss then
		UserInterfaceHandler.RefreshBossInfo()
	end
end

function EnemyClass:SetHealthPercentage(p: number)
	self:_HandleHealthChange((math.ceil(self.HealthHandler:GetMaxHealth() * p)))
end

function EnemyClass:SetHealth(p: number)
	self:_HandleHealthChange(p)
end

function EnemyClass:_HandleHealthChange(p: number)
	local health = self.HealthHandler:GetHealth()
	self.HealthHandler:SetHealth(p)

	if self.PreventDeathUntilAbilityExecuted and (self.HealthHandler:GetHealth() == 0 or health == 0) then
		UserInterfaceHandler.RefreshBossInfo()
	end
end

function EnemyClass:SetMaxHealth(p: number)
	self.HealthHandler:SetMaxHealth(p)
end

function EnemyClass:SetShieldPercentage(p: number)
	local v10 = math.ceil(self.HealthHandler:GetMaxShield() * p)
	self.HealthHandler:SetShield(v10)
end

function EnemyClass:SetShield(p: number)
	self.HealthHandler:SetShield(p)
end

function EnemyClass:SetMaxShield(p: number)
	self.HealthHandler:SetMaxShield(p)
end

function EnemyClass:SetBodyHeatPercentage(bodyHeatPercentage: number)
	self.BodyHeatPercentage = bodyHeatPercentage
end

function EnemyClass:SetBurnTimeLeft(p: string, p2: number)
	self.BurnHandler:SetBurnTimeLeft(p, p2)
end

function EnemyClass:AbilityUsed(p)
	if self.AbilityHandler then
		self.AbilityHandler:AbilityUsed(p)
	else
		warn("Enemy used ability but doesn't have ability handler")
	end
end

function EnemyClass:AbilityInterrupted(p)
	if self.AbilityHandler then
		self.AbilityHandler:AbilityInterrupted(p)
	else
		warn("Enemy ability interrupted but doesn't have ability handler")
	end
end

function EnemyClass.FaceTurretToTarget(player, player2, value: number)
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

function EnemyClass:SetStealth(stealth: boolean)
	self.Stealth = stealth
end

function EnemyClass:SetStunned(activeStuns)
	self.ActiveStuns = activeStuns
	self.Stunned = activeStuns and #activeStuns > 0
end

function EnemyClass:SetExtraDamageMultiplier(damageMultiplier: number, extraDamageMultiplier: number)
	self.DamageMultiplier = damageMultiplier
	self.ExtraDamageMultiplier = extraDamageMultiplier
end

function EnemyClass:SpeedMultiplierChanged(p: number)
	local v10 = self.IgnoreAdditionalSpeedMultiplier and p or DEFAULT_SPEED_MULTIPLIER
	self.Character:SetSpeedMultiplier(v10)

	if self.AbilityHandler then
		self.AbilityHandler:SetSpeedMultiplier(v10)
	end
end

function EnemyClass:ApplyBuffData(p)
	self.BuffHandler:ApplyBuffData(p, self:Alive())
end

function EnemyClass:RemoveBuffData(p)
	self.BuffHandler:RemoveBuffData(p)
end

function EnemyClass:RefreshBuffData(p)
	self.BuffHandler:RefreshBuffData(p)
end

function EnemyClass:SecondLifeActivated()
	if self.OnSecondLife then
		return
	end

	local secondLifeData = self.SecondLifeData

	if not secondLifeData then
		warn("SecondLifeData is nil")
		return
	end

	if secondLifeData.NewDisplayName then
		self.DisplayName = secondLifeData.NewDisplayName
	end

	if secondLifeData.NoCash then
		self.NoCash = true
	end

	self.OnSecondLife = true
end

function EnemyClass:SetAirUnit(isAirUnit: boolean)
	self.IsAirUnit = isAirUnit
	self.BuffHandler:SetAirUnit(self.IsAirUnit)
end

function EnemyClass:GetIsAirUnit()
	return self.IsAirUnit
end

function EnemyClass:_GetAttackClientData(p: number)
	local attackClientDataTable = self.AttackClientDataTable
	local v10 = self.UsePrimaryAttackDataForClient and 1 or p
	return attackClientDataTable and attackClientDataTable[v10]
end

function EnemyClass:_RenderProjectileForAttack(p: number, object, flag: boolean?, flag2: boolean?)
	local attackClientData = self:_GetAttackClientData(p)

	if not attackClientData then
		warn("No attack client data found for attack handler index " .. tostring(p))
		return
	end

	local attackProjectileConfig = attackClientData.AttackProjectileConfig
	local position = object:GetPosition()

	if attackProjectileConfig.NoPhysicalProjectile then
		if flag then
			self:FaceEnemy(p, object)
		elseif flag2 then
			self:FaceMapEntity(p, object)
		else
			self:FaceTower(p, object)
		end
	else
		local overrideGoalPosition = nil

		if attackClientData.IsPiercing and not object:GetIsAirUnit() then
			local range = attackClientData.Range
			local v10 = position - self.CFrame.Position

			if v10.Magnitude < range then
				overrideGoalPosition = self.CFrame.Position + range * v10.Unit
			end
		end

		local timeToHitForRangedProjectile = ProjectileUtilities.GetTimeToHitForRangedProjectile(
			self.CFrame.Position,
			overrideGoalPosition or position,
			attackProjectileConfig
		)
		local pathEntity

		if flag then
			pathEntity = Enums.EntityClass.PathEntity
		elseif flag2 then
			pathEntity = Enums.EntityClass.MapEntity
		else
			pathEntity = Enums.EntityClass.Tower
		end

		local v10 = {
			OriginEntityClass = Enums.EntityClass.Enemy,
			TargetEntityClass = pathEntity,
			OriginHash = self.Hash,
			TargetHash = object.Hash,
			TimeToHit = timeToHitForRangedProjectile,
			OverrideGoalPosition = overrideGoalPosition,
			FaceTarget = true,
			ForceFaceTarget = true,
			ProjectileConfig = attackProjectileConfig,
			BurstIndex = self:_GetAttackBurstIndex(p)
		}
		ProjectileHandler.NewProjectile(v10)
	end
end

function EnemyClass:_HandleRenderHitEffect(p: number, player, torsoPosition: Vector3?)
	if not (player or torsoPosition) then
		warn("No goal position could be determined for rendering hit effect")
		return
	end

	local attackClientData = self:_GetAttackClientData(p)
	local clientHitEffectData = attackClientData and attackClientData.ClientHitEffectData

	if not clientHitEffectData then
		return
	end

	if attackClientData.AttackIsProjectile then
		warn("Projectile with ClientHitEffectData detected. Set hit effects in the projectile instead")
		return
	end

	if not torsoPosition then
		local character = player.Character

		if character:GetCharacterModel():GetAttribute("TargetTorsoBounds") then
			torsoPosition = EntityUtilities.GetPointOnPartBounds(self:GetPosition(), character:GetRealTorso())
		else
			torsoPosition = clientHitEffectData.TargetTorsoInsteadOfGround and player:GetTorsoPosition()
				or player:GetPosition()
		end
	end

	local randomOffsetPosition = ProjectileUtilities.RandomOffsetPosition(
		torsoPosition,
		clientHitEffectData.VarianceXZ,
		clientHitEffectData.VarianceY,
		clientHitEffectData.VarianceYOnlyDown
	)
	local v10 = {
		Name = clientHitEffectData.EffectName,
		Position = randomOffsetPosition,
		Delay = clientHitEffectData.Delay or attackClientData.DamageDelay
	}
	VisualEffectHandler.NewVisualEffect(v10)
end

function EnemyClass:Attack(p: number, p2, flag: boolean?, flag2: boolean?)
	local attackClientData = self:_GetAttackClientData(p)

	if not attackClientData or attackClientData.IgnoreOnClient then
		return
	end

	local latestAttackedTarget, module, module2

	if flag2 then
		local module3 = require(mapEntityClass)
		latestAttackedTarget = module3.GetMapEntity(p2)

		if not latestAttackedTarget then
			if flag then
				module = require(pathEntityClass)
				latestAttackedTarget = module.GetPathEntity(p2)

				if not latestAttackedTarget then
					module2 = require(towerClass)
					latestAttackedTarget = module2.GetTower(p2)
				end
			else
				module2 = require(towerClass)
				latestAttackedTarget = module2.GetTower(p2)
			end
		end
	elseif flag then
		module = require(pathEntityClass)
		latestAttackedTarget = module.GetPathEntity(p2)

		if not latestAttackedTarget then
			module2 = require(towerClass)
			latestAttackedTarget = module2.GetTower(p2)
		end
	else
		module2 = require(towerClass)
		latestAttackedTarget = module2.GetTower(p2)
	end

	if attackClientData.AttackIsProjectile then
		self:_RenderProjectileForAttack(p, latestAttackedTarget, flag, flag2)
	elseif flag then
		self:FaceEnemy(p, latestAttackedTarget)
	elseif flag2 then
		self:FaceMapEntity(p, latestAttackedTarget)
	else
		self:FaceTower(p, latestAttackedTarget)
	end

	attackClientData.LatestAttackedTarget = latestAttackedTarget
	attackClientData.TimeSinceLastAttack = 0
	attackClientData.CurrentTargetIsPathEntity = flag or false
	attackClientData.CurrentTargetIsMapEntity = flag2 or false
	self:_Attacked(p, attackClientData)
	self:_HandleRenderHitEffect(p, latestAttackedTarget)

	if latestAttackedTarget and attackClientData.TriggerDefaultBeamEffect then
		self.Character:RunDefaultBeamEffects(true, latestAttackedTarget.Character, nil, attackClientData.DamageDelay)
	end
end

function EnemyClass:_GetAttackAnimation(p: number)
	local attackBurstIndex = self:_GetAttackBurstIndex(p)
	local primaryAnimationHandler = self.Character.PrimaryAnimationHandler
	local v10 = nil

	if primaryAnimationHandler then
		if attackBurstIndex then
			v10 = primaryAnimationHandler.Animations["Attack" .. attackBurstIndex]
		end

		return v10 or primaryAnimationHandler.Animations.Attack
	end

	return v10
end

function EnemyClass:_Attacked(p: number, _)
	local character = self.Character
	local primaryAnimationHandler = self.Character.PrimaryAnimationHandler
	local attackAnimation = self:_GetAttackAnimation(p)
	local v10 = false

	if attackAnimation then
		local flag = false

		if self.NoRestartAttackAnimationIfPlaying and primaryAnimationHandler:GetState() == attackAnimation.Name then
			if self.CanPlayAttackAnimationAgain then
				attackAnimation:SetPlayAgainWhenFinished()
			end
		else
			flag = true
		end

		if flag then
			self:SetAnimationState(attackAnimation.Name)
			v10 = self.Stopped and true or false
		end
	else
		v10 = true
	end

	if v10 then
		self.Character:OverrideDefaultAnimationState("Idle")
	end

	character:Attacked(nil, p)
	self:_BurstAttackHandling(p)
end

function EnemyClass:_GetAttackBurstIndex(p: number)
	local attackClientData = self:_GetAttackClientData(p)
	return attackClientData and attackClientData.IsBurst and attackClientData.AttackBurstIndex
end

function EnemyClass:_BurstAttackHandling(p: number)
	local attackClientData = self:_GetAttackClientData(p)

	if attackClientData and attackClientData.IsBurst then
		attackClientData.AttackBurstIndex += 1

		if attackClientData.AttackBurstIndex > attackClientData.BurstSize then
			attackClientData.AttackBurstIndex = 1
		end

		attackClientData.TimeUntilResetAttackBurstIndex = 2 * attackClientData.BurstInterval
	end
end

function EnemyClass:TargetChanged(p: number, p2: number, flag: boolean?, flag2: boolean?)
	local attackClientData = self:_GetAttackClientData(p)

	if not attackClientData then
		return
	end

	if p2 == 0 then
		attackClientData.CurrentTarget = nil
		return
	end

	local currentTarget, module, module2

	if flag2 then
		local module3 = require(mapEntityClass)
		currentTarget = module3.GetMapEntity(p2)

		if not currentTarget then
			if flag then
				module = require(pathEntityClass)
				currentTarget = module.GetPathEntity(p2)

				if not currentTarget then
					module2 = require(towerClass)
					currentTarget = module2.GetTower(p2)
				end
			else
				module2 = require(towerClass)
				currentTarget = module2.GetTower(p2)
			end
		end
	elseif flag then
		module = require(pathEntityClass)
		currentTarget = module.GetPathEntity(p2)

		if not currentTarget then
			module2 = require(towerClass)
			currentTarget = module2.GetTower(p2)
		end
	else
		module2 = require(towerClass)
		currentTarget = module2.GetTower(p2)
	end

	if currentTarget then
		attackClientData.CurrentTarget = currentTarget
		attackClientData.CurrentTargetIsPathEntity = flag or false
		attackClientData.CurrentTargetIsMapEntity = flag2 or false
	elseif flag then
		print(`Enemy TargetChanged: PathEntity w/ hash {p2} doesn't exist`)
	elseif flag2 then
		print(`Enemy TargetChanged: MapEntity w/ hash {p2} doesn't exist`)
	else
		print(`Enemy TargetChanged: Tower w/ hash {p2} doesn't exist`)
	end
end

function EnemyClass.IsInStasis(p)
	return p.InStasis and not p.UnstasisStarted
end

function EnemyClass:SetStasis(unstasisStarted: boolean, _: boolean, _: boolean)
	if self.UnstasisStarted ~= unstasisStarted then
		if not unstasisStarted then
			warn("Going back into stasis not supported")
		end

		self.UnstasisStarted = unstasisStarted

		if self.UnstasisAnimationName then
			self:SetAnimationState(self.UnstasisAnimationName)
		end

		if self.IsBoss or self.IsMiniBoss then
			UserInterfaceHandler.RefreshBossInfo()
		end
	end
end

function EnemyClass:TeleportToPathIndexAndPercentage(p: number, p2: number)
	local character = self.Character
	character:PlayPreTeleportEffects()
	self.MovementHandler:TeleportToPathIndexAndPercentage(p, p2)
	self.CFrame = self.MovementHandler:GetRealCFrame()
	character:SetCFrame(self.CFrame, true)
	character:PlayPostTeleportEffects()
end

function EnemyClass:KnockedBack(knockbackGoalPathPercentage: number, knockbackHeightOverride: number?, value: number?, knockbackSuspendEffectName: string?, p: number?, p2: number?)
	self.KnockbackActive = true
	self.KnockbackRiseTime = p or KNOCKBACK_TWEEN_TIME / 2
	self.KnockbackFallTime = p2 or KNOCKBACK_TWEEN_TIME / 2
	self.KnockbackSuspendTime = value or 0
	self.KnockbackTotalTime = self.KnockbackRiseTime + self.KnockbackSuspendTime + self.KnockbackFallTime
	self.KnockbackTimeLeft = self.KnockbackTotalTime
	self.KnockbackStart = self.MovementHandler:GetRealCFrame(true)
	self.KnockbackGoalPathPercentage = knockbackGoalPathPercentage
	self.KnockbackHeightOverride = knockbackHeightOverride
	self.KnockbackSuspendEffectName = knockbackSuspendEffectName

	if self.KnockbackSuspendVFX then
		self.KnockbackSuspendVFX:StopEarly(true)
		self.KnockbackSuspendVFX = nil
	end

	self.MovementHandler:KnockedBack(knockbackGoalPathPercentage)
	self:_RunKnockbackLogic(0)
end

function EnemyClass:_RunKnockbackLogic(p: number)
	local movementHandler = self.MovementHandler
	local knockbackStart = self.KnockbackStart
	local realCFrame = movementHandler:GetRealCFrame(true)
	self.KnockbackTimeLeft = math.max(0, self.KnockbackTimeLeft - p)

	if self.KnockbackTimeLeft > 0 then
		local knockbackTotalTime = self.KnockbackTotalTime
		local knockbackRiseTime = self.KnockbackRiseTime
		local knockbackFallTime = self.KnockbackFallTime
		local knockbackSuspendTime = self.KnockbackSuspendTime
		local v10 = knockbackTotalTime - self.KnockbackTimeLeft
		local v11

		if v10 < knockbackRiseTime then
			v11 = 0.5 * (v10 / knockbackRiseTime)
		else
			v11 = v10 < knockbackRiseTime + knockbackSuspendTime and 0.5
				or 0.5 + 0.5 * ((v10 - knockbackRiseTime - knockbackSuspendTime) / knockbackFallTime)
		end

		local v12

		if v11 <= 0.5 then
			v12 = knockbackSuspendTime > 0
		else
			v12 = false
		end

		if v12 and not self.KnockbackSuspendVFX and self.KnockbackSuspendEffectName then
			local realTorso = self.Character:GetRealTorso()
			local vfxScaleForModel = EnemyBuffUtilities.GetVFXScaleForModel(self.Character:GetCharacterModel())
			self.KnockbackSuspendVFX = VisualEffectHandler.NewVisualEffect({
				Name = self.KnockbackSuspendEffectName,
				FollowPart = realTorso,
				IsContinuous = true,
				PlayUntilManuallyStopped = true,
				Scale = vfxScaleForModel
			})
		elseif not v12 and self.KnockbackSuspendVFX then
			self.KnockbackSuspendVFX:StopEarly(true)
			self.KnockbackSuspendVFX = nil
		end

		local vector = Vector3.new(
			0,
			4 * (self.KnockbackHeightOverride or _G.KNOCKBACK_HEIGHT) * (-(v11 - 0.5) ^ 2 + 0.25),
			0
		)
		local v13 = knockbackStart:Lerp(realCFrame, v11 ^ 0.8) + vector
		local v14 = v13.Position - realCFrame.Position
		local v15 = v13.Rotation * realCFrame.Rotation:Inverse()
		movementHandler:SetKnockbackOffset(CFrame.new(v14) * v15)
	else
		if self.KnockbackSuspendVFX then
			self.KnockbackSuspendVFX:StopEarly(true)
			self.KnockbackSuspendVFX = nil
		end

		self.KnockbackSuspendEffectName = nil
		movementHandler:RemoveKnockbackOffset()
		self.KnockbackActive = false
		self.KnockbackHeightOverride = nil
		self.KnockbackSuspendTime = 0
	end

	self.Character:SetMovementAnimationSpeed(movementHandler:GetAnimationSpeed())
end

function EnemyClass:BountyCountChanged(p: number)
	self.BountyDisplayHandler:SetBountyCount(p)
end

function EnemyClass:FirstPersonTargetable()
	return not self.Untargetable
		and not (self.InStasis or self.Invulnerable)
		and self.PVPTeamIndex == TeamUtilities.GetLocalPlayerTeamIndex()
end

function EnemyClass:ShouldTakeNoDamage()
	return self.TakeNoDamage
end

function EnemyClass:FirstPersonDamage(p: number, p2: string, flag: boolean, flag2: boolean, vector: Vector3, flag3: boolean)
	if not self:FirstPersonTargetable() then
		return
	end

	local v10 = EnemyUtilities.GetAdjustedDamage(
		p,
		p2,
		flag2,
		self.DamageReductionMap,
		self.MaximumDamage,
		self.DamageResistanceModifier
	) * self.DamageMultiplier
	local v11 = self:ShouldTakeNoDamage() and 0 or v10
	local healthHandler = self.HealthHandler
	local v12 = false
	local v13 = false
	local isShieldActive = healthHandler:IsShieldActive()
	local shield = healthHandler:GetShield()
	local v14

	if shield + healthHandler:GetHealth() <= v11 and self.KillShotDeboucenceTimeLeft <= 0 then
		self.KillShotDeboucenceTimeLeft = 1
		v14 = true
	else
		v14 = false
	end

	if isShieldActive then
		if shield <= v11 then
			if self.ShieldBreakDebounceTimeLeft <= 0 then
				self.ShieldBreakDebounceTimeLeft = 1
				v13 = true
				v12 = true
			end
		elseif self.ShieldBreakDebounceTimeLeft <= 0 then
			v13 = true
		end
	end

	if v11 > 0 then
		self.Character:TookFirstPersonDamage(v11, flag, v13, flag2, vector, flag3)
	end

	return v14, v12, v13
end

function EnemyClass:SetMaximumDamage(maximumDamage: number)
	self.MaximumDamage = maximumDamage
end

function EnemyClass:_SetFrozen(frozen: boolean)
	if frozen ~= self.Frozen then
		self.Frozen = frozen
		self:_HandleOverlayPartState()
	end
end

function EnemyClass:_HandleOverlayPartState()
	if self.IsAlive then
		local character = self.Character
		local buffHandler = self.BuffHandler

		if self.Frozen then
			character:Freeze(true)
		else
			character:Thaw(true)
		end

		character:ToggleEnemyUberHighlight(buffHandler:IsUbered())
	end
end

function EnemyClass.Initialize()
	event36:AttachCallback(function(p: number?)
		if p then
			EnemyClass.PreloadEnemiesForWave(p + 1)
		end
	end)
	NetworkingHandler.GetEvent("PVPSentEnemyMarker"):AttachCallback(function(p: number, senderName: string, _: number, senderUserId: number)
		local v10 = v3[p]

		if not v10 then
			v6[p] = { SenderName = senderName, SenderUserId = senderUserId }
			return
		end

		v10.SenderName = senderName
		v10.SenderUserId = senderUserId
		AttachPVPSentMarker(v10)
	end)
	event:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			if v10.Creation then
				EnemyClass.New(v10.Data)
			else
				local data = v10.Data
				local hash = data.Hash
				local endReached = data.EndReached
				local immediate = data.Immediate
				local deathData = data.DeathData
				local v11 = v3[hash]

				if v11 then
					v11:Destroy(immediate, endReached, deathData)
				else
					print("Didn't find enemy to remove with hash " .. tostring(hash))
				end
			end
		end
	end)
	event5:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v10 = item[1]
			local v11 = item[2]
			local v12 = v3[v10]

			if v12 then
				v12:SetMaxHealth(v11)
			end
		end
	end)
	event6:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndPercentage, v10 = NetworkingUtilities.DecompressHashAndPercentage(item)
			local v11 = v3[decompressHashAndPercentage]

			if v11 then
				v11:SetHealthPercentage(v10)
			end
		end
	end)
	event7:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v11 = v3[decompressHashAndInteger]

			if v11 then
				v11:SetHealth(v10)
			end
		end
	end)
	event8:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v10 = item[1]
			local v11 = item[2]
			local v12 = v3[v10]

			if v12 then
				v12:SetMaxShield(v11)
			end
		end
	end)
	event9:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndPercentage, v10 = NetworkingUtilities.DecompressHashAndPercentage(item)
			local v11 = v3[decompressHashAndPercentage]

			if v11 then
				v11:SetShieldPercentage(v10)
			end
		end
	end)
	event10:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v11 = v3[decompressHashAndInteger]

			if v11 then
				v11:SetShield(v10)
			end
		end
	end)
	event11:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v11 = v3[decompressHashAndInteger]

			if v11 then
				v11:SetBodyHeatPercentage(v10 / 100)
			end
		end
	end)
	event2:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v11 = v3[decompressHashAndInteger]

			if not v11 then
				continue
			end

			local v12 = v10 * 0.0001
			v11.MovementHandler:SetSpeed(v12)

			if not v11.NoAdjustMovementAnimationSpeed then
				v11.Character:SetMovementAnimationSpeed(v11.MovementHandler:GetAnimationSpeed())
			end
		end
	end)
	event3:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v11 = v3[decompressHashAndInteger]

			if not v11 then
				continue
			end

			local v12 = v10 * 0.0001
			v11.MovementHandler:SetDefaultSpeed(v12)
			v11.Character:SetMovementAnimationSpeed(v11.MovementHandler:GetAnimationSpeed())
		end
	end)
	event4:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v11 = v3[decompressHashAndInteger]

			if not v11 then
				continue
			end

			local v12 = v10 * 0.00001
			v11.MovementHandler:SetTopSpeedMultiplier(v12)
		end
	end)
	event12:AttachCallback(function(list)
		for i = 1, #list, 2 do
			local decompressHashAndNumber1Place, v10 = NetworkingUtilities.DecompressHashAndNumber1Place(list[i])
			local v11 = list[i + 1]
			local v12 = v3[decompressHashAndNumber1Place]

			if v12 then
				v12:SetBurnTimeLeft(v11, v10)
			end
		end
	end)
	event13:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v11 = v10 == 1
			local v12 = v3[decompressHashAndInteger]

			if v12 then
				v12:SetStopped(v11)
			end
		end
	end)

	for i = 1, #v do
		local v10 = i
		v[i]:AttachCallback(function(list)
			for _, v11 in ipairs(list) do
				local v12 = v11[1]
				local v13 = v11[2]
				local v14 = v11[3]
				local v15 = v11[4]
				local v16 = v3[v12]

				if v16 then
					v16:TargetChanged(v10, v13, v14, v15)
				else
					print("Enemy TargetChangedEvent: Enemy doesn't exist")
					print(v12)
					break
				end
			end
		end)
	end

	for i = 1, #v2 do
		local v10 = i
		v2[i]:AttachCallback(function(list)
			for _, v11 in ipairs(list) do
				local v12 = v11[1]
				local v13 = v11[2]
				local v14 = v11[3]
				local v15 = v11[4]
				local v16 = v3[v12]

				if v16 then
					v16:Attack(v10, v13, v14, v15)
				else
					print("Enemy AttackEvent: Enemy doesn't exist")
					break
				end
			end
		end)
	end

	event15:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v10 = item[1]
			local v11 = item[2]
			local v12 = item[3]
			local v13 = v3[v10]

			if v13 then
				v13:FacePositionUntilNextMove(v11, v12)
			end
		end
	end)
	event14:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local v11 = v10[1]
			local v12 = v10[2]
			local v13 = v3[v11]

			if v13 then
				v13:SetAnimationState(v12)
			else
				print("AnimationStateChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event16:AttachCallback(function(list)
		local v10 = list[1]
		local v11 = list[2]
		local v12 = v3[v10]

		if v12 then
			v12:AbilityUsed(v11)
		end
	end)
	event17:AttachCallback(function(list)
		local v10 = list[1]
		local v11 = list[2]
		local v12 = v3[v10]

		if v12 then
			v12:AbilityInterrupted(v11)
		end
	end)
	event18:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local decompressHashAndInteger, v11 = NetworkingUtilities.DecompressHashAndInteger(v10)
			local v12 = v11 == 1
			local v13 = v3[decompressHashAndInteger]

			if v13 then
				v13:SetStealth(v12)
			else
				print("EnemiesStealthStatusChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event19:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local v11 = v10[1]
			local v12 = v10[2]
			local v13 = v3[v11]

			if v13 then
				v13:SetStunned(v12)
			else
				print("EnemiesStunnedStatusChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event20:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local v11 = v10[1]
			local v12 = v10[2]
			local v13 = v10[3]
			local v14 = v3[v11]

			if v14 then
				v14:SetExtraDamageMultiplier(v12, v13)
			else
				print("EnemiesExtraDamageChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event21:AttachCallback(function(items)
		for _, item in pairs(items) do
			local enemyHash = item.EnemyHash
			local v10 = v3[enemyHash]

			if v10 then
				v10:ApplyBuffData(item)
			else
				print("Didn't find enemy with hash " .. tostring(enemyHash) .. " to apply buff data to")
			end
		end
	end)
	event22:AttachCallback(function(items)
		for _, item in pairs(items) do
			local enemyHash = item.EnemyHash
			local v10 = v3[enemyHash]

			if v10 then
				v10:RemoveBuffData(item)
			else
				print("Didn't find enemy with hash " .. tostring(enemyHash) .. " to remove buff data from")
			end
		end
	end)
	event23:AttachCallback(function(items)
		for _, item in pairs(items) do
			local enemyHash = item.EnemyHash
			local v10 = v3[enemyHash]

			if v10 then
				v10:RefreshBuffData(item)
			else
				print("Didn't find enemy with hash " .. tostring(enemyHash) .. " to refresh buff data for")
			end
		end
	end)
	event24:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v10 = v3[item]

			if v10 then
				v10:SecondLifeActivated()
			else
				print("Didn't find enemy with hash " .. tostring(item) .. " to refresh buff data for")
			end
		end
	end)
	event25:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local v11 = v10[1]
			local v12 = v10[2]
			local v13 = v10[3]
			local v14 = v10[4]
			local v15 = v3[v11]

			if v15 then
				v15:SetStasis(v12, v13, v14)
			else
				print("EnemyStasisChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event26:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v10 = item[1]
			local v11 = item[2]
			local v12 = item[3]
			local v13 = v3[v10]

			if v13 then
				v13:TeleportToPathIndexAndPercentage(v11, v12)
			else
				print("EnemyTeleportedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event27:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v10 = item[1]
			local v11 = item[2]
			local v12 = item[3]
			local v13 = item[4]
			local v14 = item[5]
			local v15 = item[6]
			local v16 = item[7]
			local v17 = v3[v10]

			if v17 then
				v17:KnockedBack(v11, v12, v13, v14, v15, v16)
			else
				print("EnemyKnockedBackEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event28:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v10 = item[1]
			local v11 = item[2]
			local v12 = v3[v10]

			if v12 then
				v12:BountyCountChanged(v11)
			else
				print("EnemyBountyChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event29:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local invulnerable = v10 == 1
			local v11 = v3[decompressHashAndInteger]

			if v11 then
				v11.Invulnerable = invulnerable
			else
				print("EnemyInvulnerableChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event30:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(item)
			local takeNoDamage = v10 == 1
			local v11 = v3[decompressHashAndInteger]

			if v11 then
				v11.TakeNoDamage = takeNoDamage
			else
				print("EnemyTakeNoDamageChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event31:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local v11 = v10[1]
			local v12 = v10[2]
			local v13 = v3[v11]

			if v13 then
				v13:SetMaximumDamage(v12)
			else
				print("EnemyMaximumDamageChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event32:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local decompressHashAndInteger, v11 = NetworkingUtilities.DecompressHashAndInteger(v10)
			local v12 = v11 == 1
			v3[decompressHashAndInteger]:SetAirUnit(v12)
		end
	end)
	event33:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local decompressHashAndInteger, v11 = NetworkingUtilities.DecompressHashAndInteger(v10)
			local v12 = v3[decompressHashAndInteger]

			if v12 then
				v12.AllDamageReduction = v11 / 100000
			else
				print("EnemyAllDamageReductionChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event34:AttachCallback(function(list)
		for _, v10 in ipairs(list) do
			local decompressHashAndInteger, v11 = NetworkingUtilities.DecompressHashAndInteger(v10)
			local v12 = v3[decompressHashAndInteger]

			if v12 then
				v12.DamageResistanceModifier = (v11 - 100000) / 100000
			else
				print("EnemyDamageResistanceModifierChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
end

return EnemyClass