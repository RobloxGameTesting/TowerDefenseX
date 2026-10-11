local TowerClass = {}
TowerClass.__index = TowerClass

function TowerClass.__tostring(data)
	return `Tower Type: {data.Type} Hash: {data.Hash} UniqueId: {data.UniqueId}`
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("TowerTypes"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("CustomCodeTypes"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local NetworkingUtilities = require(common:WaitForChild("NetworkingUtilities"))
local QueryType = require(common:WaitForChild("QueryType"))
require(common:WaitForChild("TowerBuffUtilities"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local DashedCircleUtilities = require(common:WaitForChild("DashedCircleUtilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PlacementHandler = require(common:WaitForChild("PlacementHandler"))
require(common:WaitForChild("EntityUtilities"))
require(common:WaitForChild("AttachmentEntityUtilities"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
local TeamUtilities = require(common:WaitForChild("TeamUtilities"))
local BaseClasses = script.Parent:WaitForChild("BaseClasses")
local CharacterClass = require(BaseClasses:WaitForChild("CharacterClass"))
local AttachmentEntityHandlerClass = require(BaseClasses:WaitForChild("AttachmentEntityHandlerClass"))
local parent = script.Parent.Parent
local PlayerClass = require(parent:WaitForChild("PlayerClass"))
local userInputHandler = parent:WaitForChild("UserInputHandler")
local Placement = require(userInputHandler:WaitForChild("Placement"))
local EnemyClass = require(script.Parent:WaitForChild("EnemyClass"))
local ProjectileHandler = require(script.Parent:WaitForChild("ProjectileHandler"))
local VisualEffectHandler = require(script.Parent:WaitForChild("VisualEffectHandler"))
local EDJMusicHandler = require(script:WaitForChild("EDJMusicHandler"))
local LevelHandlerClass = require(script:WaitForChild("LevelHandlerClass"))
local AbilityHandlerClass = require(script:WaitForChild("AbilityHandlerClass"))
local BuffHandlerClass = require(script:WaitForChild("BuffHandlerClass"))
local ShipHandlerClass = require(script:WaitForChild("ShipHandlerClass"))
local HealthHandlerClass = require(script:WaitForChild("HealthHandlerClass"))
local ReloadTimeDisplayClass = require(script:WaitForChild("ReloadTimeDisplayClass"))
local DirectControlHandlerClass = require(script:WaitForChild("DirectControlHandlerClass"))
local PylonMovementHandlerClass = require(script:WaitForChild("PylonMovementHandlerClass"))
local AviatorMovementHandlerClass = require(script:WaitForChild("AviatorMovementHandlerClass"))
local color = Color3.fromRGB(255, 158, 158)
local color2 = Color3.fromRGB(137, 255, 129)
local color3 = Color3.fromRGB(255, 141, 141)
local DEADZONE_DASHED_CIRCLE_COLOR = _G.DEADZONE_DASHED_CIRCLE_COLOR
local CHARACTER_OVERLAYS = CharacterClass.CHARACTER_OVERLAYS
local MAX_AIR_TOWERS_PER_PLAYER = _G.MAX_AIR_TOWERS_PER_PLAYER
local event = BindableHandler.GetEvent("DeselectTower")
local event2 = BindableHandler.GetEvent("TowerChanged")
local event3 = BindableHandler.GetEvent("RemoveTowerCircles")
local event4 = BindableHandler.GetEvent("ResetAbilities")
local event5 = BindableHandler.GetEvent("RefreshTowerStatsDisplay")
local event6 = BindableHandler.GetEvent("UpgradeShopChangedForPlayer")
local event7 = NetworkingHandler.GetEvent("TowerFactoryQueueUpdated")
local event8 = NetworkingHandler.GetEvent("TowerTargetChanged")
local event9 = NetworkingHandler.GetEvent("TowerConvertedTargetChanged")
local event10 = NetworkingHandler.GetEvent("TowerHealTargetChanged")
local event11 = NetworkingHandler.GetEvent("TowerAttack")
local event12 = NetworkingHandler.GetEvent("TowerConvertedAttack")
local event13 = NetworkingHandler.GetEvent("TowerChainAttack")
local event14 = NetworkingHandler.GetEvent("TowerConvertedChainAttack")
local event15 = NetworkingHandler.GetEvent("TowerAttackPosition")
local event16 = NetworkingHandler.GetEvent("TowerAbilityUsed")
local event17 = NetworkingHandler.GetEvent("TowerAbilityCancelled")
local event18 = NetworkingHandler.GetEvent("TowerAnimationStateChanged")
local event19 = NetworkingHandler.GetEvent("ChangeQueryType")
local event20 = NetworkingHandler.GetEvent("TowerQueryTypeIndexChanged")
local event21 = NetworkingHandler.GetEvent("TowerUpgradeQueueUpdated")
local event22 = NetworkingHandler.GetEvent("TowerHealthChanged")
local event23 = NetworkingHandler.GetEvent("TowerMaxHealthChanged")
local event24 = NetworkingHandler.GetEvent("TowerShieldChanged")
local event25 = NetworkingHandler.GetEvent("TowerMaxShieldChanged")
local event26 = NetworkingHandler.GetEvent("TowerHasSharedShieldChanged")
local event27 = NetworkingHandler.GetEvent("TowerHasDirectShieldChanged")
local event28 = NetworkingHandler.GetEvent("TowerShieldRefreshed")
local event29 = NetworkingHandler.GetEvent("TowerDamageDealtChanged")
local event30 = NetworkingHandler.GetEvent("TowerCashEarnedChanged")
local event31 = NetworkingHandler.GetEvent("TowerSpawnTimersChanged")
local event32 = NetworkingHandler.GetEvent("TowerHealingDealtChanged")
local event33 = NetworkingHandler.GetEvent("TowerApplyBuffData")
local event34 = NetworkingHandler.GetEvent("TowerRemoveBuffData")
local event35 = NetworkingHandler.GetEvent("TowerApplyCustomBuffData")
local event36 = NetworkingHandler.GetEvent("TowerRemoveCustomBuffData")
local event37 = NetworkingHandler.GetEvent("ShipTurretFired")
local event38 = NetworkingHandler.GetEvent("TowerAliveStateChanged")
local event39 = NetworkingHandler.GetEvent("TowerRetargeted")
local event40 = NetworkingHandler.GetEvent("TowerRotated")
local event41 = NetworkingHandler.GetEvent("TowerAttackDisabledChanged")
local event42 = NetworkingHandler.GetEvent("TowerStealthStatusChanged")
local event43 = NetworkingHandler.GetEvent("TowerAirUnitPositionChanged")
local event44 = NetworkingHandler.GetEvent("TowerAviatorFlightSync")
local event45 = NetworkingHandler.GetEvent("TowerPositionChanged")
local event46 = NetworkingHandler.GetEvent("TowerVisualEffect")
local event47 = NetworkingHandler.GetEvent("TowerNewAttachmentEntity")
local event48 = NetworkingHandler.GetEvent("DynamicPriceUpdate")
local event49 = NetworkingHandler.GetEvent("TowerDirectControl")
local event50 = NetworkingHandler.GetEvent("TowerStartReload")
local event51 = NetworkingHandler.GetEvent("TowerFirstPersonHit")
local event52 = NetworkingHandler.GetEvent("TowerFirstPersonMiss")
local event53 = NetworkingHandler.GetEvent("TowerFirstPersonNewProjectile")
local event54 = NetworkingHandler.GetEvent("TowerFirstPersonSetIndex")
local event55 = NetworkingHandler.GetEvent("TowerFirstPersonMoveTo")
local event56 = NetworkingHandler.GetEvent("TowerFirstPersonAttackHit")
local event57 = NetworkingHandler.GetEvent("TowerFirstPersonAttackMiss")
local event58 = NetworkingHandler.GetEvent("TowerFirstPersonAttackProj")
local event59 = NetworkingHandler.GetEvent("TowerFirstPersonMoved")
local event60 = NetworkingHandler.GetEvent("TowerDamageMultiplierChanged")
local event61 = NetworkingHandler.GetEvent("TowerReviveStateChanged")
local event62 = NetworkingHandler.GetEvent("TowerMainAttackOverrideChanged")
local v = {}
local v2 = {}
local v3 = 0
local towers = workspace:WaitForChild("Game"):WaitForChild("Towers")
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER
local v4 = false
local v5 = nil
local v6 = nil
local LocalPlayer = Players.LocalPlayer
local stats = PlayerClass.GetLocalPlayerWrapper().Stats
local v7 = {}
local v8 = {}
local fpsParts = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore"):WaitForChild("FPSParts")

local function GetCharacter(hash: number, p: number?, p2: string, skinName: string, towerConfig, cframe: CFrame, flag: boolean, p3, flag2: boolean)
	local v9 = p and Placement.PopCachedCharacterModel(p, p2)
	local v10 = v9 ~= nil

	if v9 then
		v9:SetHash(hash)
		v9:SetParent(towers)
		v9:SetDefaultMode()
	else
		v9 = CharacterClass.New({
			Hash = hash,
			Type = p2,
			SkinName = skinName,
			EntityClass = "Tower",
			Config = towerConfig,
			SpawnCFrame = cframe,
			Parent = towers,
			Stealth = flag2
		}, p3)
	end

	v9:MarkNextCFrameAsWorldFixedBase()

	if not v9.RingHandler then
		v9:MakeRing(towerConfig.Radius, flag)
	end

	return v9, v10
end

function TowerClass.New(list, p: number?)
	assert(list, "InitData not provided")
	local hash = list[1]
	local v9 = list[2]
	local skinName = list[3]
	local position = list[4]
	local v10 = list[5]
	local queryTypeIndex = list[6]
	local ownerName = list[7]
	local v11 = list[8]
	local damageDealt = list[9]
	local state = list[10]
	local v12 = list[11]
	local v13 = list[12]
	local v14 = list[13]
	local v15 = list[14]
	local isAlive = list[15]
	local manualAimPosition = list[16]
	local cashEarned = list[17]
	local v16 = list[18]
	local rebuildsLeft = list[19]
	local _ = list[20]
	local v17 = list[21]
	local stealth = list[22]
	local v18 = list[23]
	local totalCost = list[24]
	local healingDealt = list[25]
	local v19 = list[26]
	local v20 = list[27]
	local v21 = list[28]
	local v22 = list[29]
	local v23 = list[30]
	local v24 = list[31]
	local damageMultiplier = list[32]
	local uniqueId = list[33]
	local v25 = list[34]
	local ownerPlayerWrapperKey = list[35]
	local mainAttackOverrideData = list[36]
	local pvpTeamIndex = list[37]
	assert(hash, "Tower hash not provided")
	assert(v9, "Tower type not provided")
	assert(position, "Position not provided")
	assert(v10, "Rotation not provided")
	local v26 = v[hash]

	if v26 then
		v26:Destroy(true)
	end

	local towerConfig = ResourceManager.GetTowerConfig(v9)
	assert(towerConfig, "Tower config not found for type " .. v9)
	local v27 = ResourceManager.TryGetTowerClientCustomCodeClass(towerConfig.OverrideCustomCodeName or v9)
	local customCode = v27 and v27.New(DEFAULT_SPEED_MULTIPLIER)

	if towerConfig.HasCustomCode and not customCode then
		warn("Tower " .. v9 .. " has custom code but no custom code class was found")
	elseif not towerConfig.HasCustomCode and customCode then
		warn("Tower " .. v9 .. " does not have custom code but a custom code class was found")
	end

	local playerWrapper = PlayerClass.GetPlayerWrapper(ownerPlayerWrapperKey, true)

	if not playerWrapper then
		warn("TowerClass.New: Owner player wrapper not found")
	end

	local upgradeShopDataHandler = playerWrapper and playerWrapper.UpgradeShopDataHandler
	local upgradeTypeToActiveUpgradeShopData = upgradeShopDataHandler
		and upgradeShopDataHandler:GetUpgradeTypeToActiveUpgradeShopData(v9)
	local levelHandler = LevelHandlerClass.New(v9, towerConfig, v11)
	local levelStats = levelHandler:GetLevelStats()
	local healthHandler = HealthHandlerClass.New(
		v15,
		v25,
		v20,
		v21,
		v22,
		v23,
		position,
		towerConfig.DirectShieldRadius or towerConfig.Radius,
		towerConfig.DirectShieldOffset,
		towerConfig.HelicopterMovement
	)
	local abilityHandler = AbilityHandlerClass.New(
		hash,
		levelStats,
		towerConfig.ManualAiming,
		upgradeTypeToActiveUpgradeShopData,
		towerConfig.ManualAimRetargetAbilityName
	)
	local ownedByLocalPlayer = ownerName == LocalPlayer.Name
	local cframe

	if manualAimPosition and not levelStats.DisableManualAiming then
		cframe = CFrame.new(position, (Vector3.new(manualAimPosition.X, position.Y, manualAimPosition.Z)))
	else
		cframe = CFrame.new(position) * CFrame.Angles(0, v10, 0)
	end

	local character, v28 = GetCharacter(
		hash,
		p,
		v9,
		skinName,
		towerConfig,
		cframe,
		ownedByLocalPlayer,
		levelHandler,
		stealth
	)
	local buffHandler = BuffHandlerClass.New(character, towerConfig.BuffEffectScale)
	local shipHandler

	if levelStats.ShipData then
		shipHandler = ShipHandlerClass.New(hash, levelStats, character, levelStats.ShipData, DEFAULT_SPEED_MULTIPLIER)
	end

	local attachmentEntityHandler = AttachmentEntityHandlerClass.New()
	local directControlHandler = levelStats.HasDirectControl and DirectControlHandlerClass.New(levelStats)
	local pylonMovementHandler = nil

	if levelStats.AviatorMovementConfig then
		pylonMovementHandler = AviatorMovementHandlerClass.New(levelStats, v19, cframe.Rotation)
	elseif levelStats.PylonMovementConfig then
		pylonMovementHandler = PylonMovementHandlerClass.New(levelStats, v19)
	end

	local isProjectile = levelStats.IsProjectile
	local projectileName = isProjectile and levelStats.ProjectileName
	local clientsideIsBurst = levelStats.ClientsideIsBurst
	local overridePlacementEffectName = character:GetOverridePlacementEffectName() or towerConfig.PlacementEffectName

	if overridePlacementEffectName and p then
		VisualEffectHandler.NewVisualEffect({
			Name = overridePlacementEffectName,
			Position = position,
			IgnoreSpeedMultiplier = true
		})
	end

	local v29 = {
		UniqueId = uniqueId,
		Hash = hash,
		PVPTeamIndex = pvpTeamIndex,
		OwnerPlayerWrapperKey = ownerPlayerWrapperKey,
		Owner = playerWrapper,
		OwnerName = ownerName,
		OwnedByLocalPlayer = ownedByLocalPlayer,
		Type = v9,
		SkinName = skinName,
		DisplayName = towerConfig.OverrideDisplayName or v9,
		NoHoverTooltip = towerConfig.NoHoverTooltip,
		Config = towerConfig,
		CustomCode = customCode,
		TotalCost = totalCost,
		DamageDealt = damageDealt,
		CashEarned = cashEarned,
		HealingDealt = healingDealt,
		SpawnTimers = {},
		SpawnTimersPaused = false,
		State = state,
		IsAlive = isAlive,
		IsBurning = false,
		HasTurret = character:HasTurret(),
		IsAiming = false,
		NoBuffs = towerConfig.NoBuffs,
		NoHeal = towerConfig.NoHeal,
		Destroyed = false,
		Converted = false,
		AttackDisabled = nil,
		AttackEnabledDefaultAnimation = towerConfig.AttackEnabledDefaultAnimation,
		AttackDisabledAnimation = towerConfig.AttackDisabledAnimation,
		AttackNoFaceTarget = towerConfig.AttackNoFaceTarget or character:GetAttackNoFaceTarget(),
		Stealth = stealth,
		IsAirUnit = towerConfig.PlacementType == Enums.PlacementTypes.Air or towerConfig.ForceIsAirUnit,
		BeamEffectForDefaultAttack = towerConfig.BeamEffectForDefaultAttack or character:HasBeamEffectForDefaultAttack(),
		BeamEffectDuration = towerConfig.BeamEffectDuration,
		AimAllTurretsForAttack = towerConfig.AimAllTurretsForAttack,
		TimeAlive = 0,
		DamageMultiplier = damageMultiplier,
		DamageMultiplierScalesEffects = towerConfig.DamageMultiplierScalesEffects,
		UpgradeTypeToActiveUpgradeShopData = upgradeTypeToActiveUpgradeShopData,
		CustomQueryOptions = towerConfig.ManualAiming and towerConfig.ManualAimingAllowAutoTargeting and QueryType.WithManualOption(towerConfig.CustomQueryOptions) or towerConfig.CustomQueryOptions
	}
	local manualAimingAllowAutoTargeting

	if towerConfig.ManualAiming then
		manualAimingAllowAutoTargeting = towerConfig.ManualAimingAllowAutoTargeting or nil
	end

	v29.ManualAimingAllowAutoTargeting = manualAimingAllowAutoTargeting
	v29.MainAttackOverrideData = mainAttackOverrideData
	v29.ClientsideIsBurst = character:GetOverrideBurstSize() or clientsideIsBurst or levelStats.IsBurst
	v29.ClientsideBurstSize = character:GetOverrideBurstSize()
		or clientsideIsBurst and levelStats.ClientsideBurstSize
		or levelStats.BurstSize
	v29.ClientsideBurstInterval = character:GetOverrideBurstInterval()
		or clientsideIsBurst and levelStats.ClientsideBurstInterval
		or levelStats.BurstInterval
	v29.AttackIsProjectile = isProjectile
	v29.AttackProjectileConfig = isProjectile and ResourceManager.GetProjectileConfig(projectileName)
	v29.AttackAnimationSpeedMultiplier = 1
	v29.AttackBurstIndex = 1
	v29.TimeUntilResetAttackBurstIndex = 0
	v29.NoRestartAttackAnimationIfPlaying = towerConfig.NoRestartAttackAnimationIfPlaying
	v29.CanPlayAttackAnimationAgain = towerConfig.CanPlayAttackAnimationAgain
	v29.SpecialBurstHandlingForModel = towerConfig.SpecialBurstHandlingForModel
	v29.ClientsideAttackTargetPathPosition = towerConfig.ClientsideAttackTargetPathPosition
	v29.ClientsideAttackTargetTorsoPosition = towerConfig.ClientsideAttackTargetTorsoPosition
	v29.QueryTypeIndex = queryTypeIndex
	v29.IsShip = towerConfig.IsShip
	v29.ShipHandler = shipHandler
	v29.GoalPosition = nil
	v29.FPSPosition = nil
	v29.CFrame = cframe
	v29.SpawnCFrame = cframe
	v29.LastFacePosition = nil
	v29.CurrentTarget = nil
	v29.CurrentTargetIsTower = false
	v29.CurrentHealTarget = nil
	v29.TimeSinceLastHadTarget = 0

	if levelStats.DisableManualAiming or not manualAimPosition then
		manualAimPosition = nil
	end

	v29.ManualAimPosition = manualAimPosition
	v29.LastAttackedTargetWithDamageDelay = nil
	v29.DamageDelayRemaining = 0
	v29.Radius = towerConfig.Radius
	v29.Character = character
	v29.LevelHandler = levelHandler
	v29.HealthHandler = healthHandler
	v29.AbilityHandler = abilityHandler
	v29.BuffHandler = buffHandler
	v29.AttachmentEntityHandler = attachmentEntityHandler
	v29.DirectControlHandler = directControlHandler
	v29.PylonMovementHandler = pylonMovementHandler
	v29.PlacementDashedCircleData = nil
	v29.AbilityDashedCircleData = nil
	v29.DeadzoneDashedCircleData = nil
	v29.UseMovingRangeCircle = towerConfig.UseMovingRangeCircle
	v29.OverrideUseMovingRangeCircle = levelStats.OverrideUseMovingRangeCircle
	v29.DisplayReloadTime = towerConfig.DisplayReloadTime
	v29.DisplayShieldRefreshTime = towerConfig.DisplayShieldRefreshTime
	v29.ReloadTimeDisplay = nil
	v29.TimeUntilNextAttack = v16 or 0
	v29.ShieldRefreshCooldown = v24 or 0
	v29.CanRebuild = levelStats.CanRebuild
	v29.RebuildTime = levelStats.RebuildTime
	v29.RebuildTimeRemaining = 0
	v29.RebuildsLeft = rebuildsLeft
	v29.HelicopterCrashLocation = nil
	v29.HelicopterCrashDuration = nil
	v29.InternalHelicopterCrashData = nil
	v29.UserInputHovered = false
	v29.Selected = false
	v[v29.Hash] = v29
	v2[character:GetTorso()] = v29
	character:SetAnimationState(state)
	v3 += 1

	if ownedByLocalPlayer then
		stats:TowerAdded(v9)
	end

	setmetatable(v29, TowerClass)

	if abilityHandler then
		abilityHandler:SetTower(v29)

		if customCode then
			abilityHandler:SetCustomCode(customCode)
		end
	end

	v29:TargetChanged(v14)
	v29:_UpdateManualAimRetargetState()

	for _, v30 in pairs(v12) do
		v29:ApplyBuffData(v30)
	end

	for _, v30 in pairs(v13) do
		v29:ApplyCustomBuffData(v30)
	end

	attachmentEntityHandler:SetParentEntity(v29)

	if directControlHandler then
		directControlHandler:SetTower(v29)
	end

	if pylonMovementHandler then
		v29:PositionCharacterForPylonMovement(0, true)
		v29:_PositionRingForPylonMovement()
	end

	if v28 then
		local module = require(userInputHandler)
		module.SelectTowerFromInitialPlacement(v29, p)
		character:TowerInitialPlacement(levelStats)
	end

	if customCode then
		character:SetCustomCode(customCode)
		customCode:Initialize(v29, towerConfig)

		if levelHandler:GetOverallLevel() > 0 then
			customCode:Upgraded(levelStats)
		end
	end

	if v9 == Enums.Towers.EDJ then
		EDJMusicHandler.EDJAdded(v29)
	end

	if towerConfig.DisplayReloadTime or towerConfig.DisplayShieldRefreshTime then
		v29.ReloadTimeDisplay = ReloadTimeDisplayClass.New(character:GetTorso())
	end

	v29:SetAttackDisabled(v17, true)

	if stealth then
		character:RunStealthShimmer(true)
	else
		character:StopStealthShimmer()
	end

	if v29.IsAirUnit then
		v29:SetPositionForAirUnit(cframe.Position.X, cframe.Position.Z)

		if not towerConfig.IgnoreAirPlacementLimit then
			v8[ownerName] = (v8[ownerName] or 0) + 1
		end
	end

	if v18 then
		for _, v30 in pairs(v18) do
			v29:NewAttachmentEntity(v30)
		end
	end

	v29:SetDamageMultiplier(damageMultiplier)
	v29:UpgradeShopDataChanged()
	return v29
end

function TowerClass.SpawnExistingTowers(list)
	local v9 = {}

	for _, v10 in ipairs(list) do
		local v11 = v10[1]
		local v12 = v10[20]

		if v[v11] then
			continue
		end

		local v13 = TowerClass.New(v10)

		if v12 then
			v9[v13] = v12
		end
	end

	for k, v10 in pairs(v9) do
		k:HealTargetChanged(v10)
	end
end

function TowerClass.GetTower(p: number)
	return v[p]
end

function TowerClass.GetTowers()
	return v
end

function TowerClass.GetTowerByTorso(p)
	return v2[p]
end

function TowerClass.GetCount()
	return v3
end

function TowerClass.AirTowerLimitReached()
	return MAX_AIR_TOWERS_PER_PLAYER <= (v8[LocalPlayer.Name] or 0)
end

function TowerClass.PlacementStarted()
	v4 = true
end

function TowerClass.PlacementStopped()
	v4 = false
end

function TowerClass.PlacementChanged(vector: Vector3, p: number)
	v5 = vector
	v6 = p
end

function TowerClass.GetClosestFriendlyTower(vector: Vector3)
	local v9 = 1e999
	local v10 = nil

	for _, v11 in pairs(v) do
		if not (v11:Alive() and v11.PVPTeamIndex == TeamUtilities.GetLocalPlayerTeamIndex()) then
			continue
		end

		local magnitude = (v11:GetPosition() - vector).Magnitude

		if not (magnitude < v9) then
			continue
		end

		v10 = v11
		v9 = magnitude
	end

	return v10
end

function TowerClass:SetSpeedMultiplier()
	DEFAULT_SPEED_MULTIPLIER = self

	for _, v9 in pairs(v) do
		v9.Character:SetSpeedMultiplier(DEFAULT_SPEED_MULTIPLIER)

		if v9.ShipHandler then
			v9.ShipHandler:SetSpeedMultiplier(DEFAULT_SPEED_MULTIPLIER)
		end

		if v9.AbilityHandler then
			v9.AbilityHandler:SetSpeedMultiplier(DEFAULT_SPEED_MULTIPLIER)
		end

		v9.AttachmentEntityHandler:SetSpeedMultiplier(DEFAULT_SPEED_MULTIPLIER)
		v9.HealthHandler:SetSpeedMultiplier(DEFAULT_SPEED_MULTIPLIER)
	end
end

function TowerClass.LogicLoop(p: number, p2: number)
	debug.profilebegin("Tower Logic")

	for _, v9 in pairs(v) do
		v9:Logic(p, p2)
	end

	debug.profileend()
end

function TowerClass:Logic(p: number, _: number)
	local healthHandler = self.HealthHandler
	local abilityHandler = self.AbilityHandler
	local buffHandler = self.BuffHandler
	local attachmentEntityHandler = self.AttachmentEntityHandler
	local directControlHandler = self.DirectControlHandler
	local pylonMovementHandler = self.PylonMovementHandler
	local character = self.Character
	local currentTarget = self.CurrentTarget
	local currentTargetIsTower = self.CurrentTargetIsTower
	local currentHealTarget = self.CurrentHealTarget
	local levelStats = self.LevelHandler:GetLevelStats()
	local v9 = directControlHandler and directControlHandler:IsActive()

	if buffHandler.BuffsChanged then
		local statMultipliers = buffHandler:GetStatMultipliers()
		abilityHandler:SetStunned(statMultipliers.Stunned)
		abilityHandler:SetDisabled(statMultipliers.DisabledAbilities)
		abilityHandler:SetConverted(statMultipliers.Converted)
		character:SetTowerConverted(statMultipliers.Converted)
		self.Converted = statMultipliers.Converted
		self:_HandleBurnState()
		self:_HandleOverlayPartState()
		self.AttackAnimationSpeedMultiplier = math.max(1, 1 + statMultipliers.FirerateMultiplier)
		self:_AdjustAttackAnimationSpeed()
		event2:Fire(self.Hash)

		if self.Selected then
			event5:Fire(self.Hash)
		end

		buffHandler.BuffsChanged = false
	end

	if not self.SpawnTimersPaused then
		for _, spawnTimer in ipairs(self.SpawnTimers) do
			spawnTimer.TimeToNextSpawn -= p
		end
	end

	if self.IsAlive then
		if self.IsAirUnit and not self.PylonMovementHandler then
			local fpsPosition

			if self.OwnedByLocalPlayer then
				if v9 then
					fpsPosition = self.FPSPosition
				else
					fpsPosition = self.GoalPosition
				end
			else
				fpsPosition = self.FPSPosition or self.GoalPosition
			end

			if fpsPosition then
				local lerped = self.CFrame.Position:Lerp(fpsPosition, p * 6)
				self.CFrame = CFrame.new(lerped) * self.CFrame.Rotation
			end
		end

		local lastAttackedTargetWithDamageDelay = self.LastAttackedTargetWithDamageDelay
		local aimTime = levelStats.AimTime
		local primaryAnimationHandler = character.PrimaryAnimationHandler
		local aim = primaryAnimationHandler and primaryAnimationHandler.Animations.Aim
		local healing = primaryAnimationHandler and primaryAnimationHandler.Animations.Healing

		if lastAttackedTargetWithDamageDelay and lastAttackedTargetWithDamageDelay:Alive() then
			if currentTargetIsTower then
				self:FaceTower(lastAttackedTargetWithDamageDelay)
			else
				self:FaceEnemy(lastAttackedTargetWithDamageDelay)
			end
		elseif currentTarget and currentTarget:Alive() then
			if aim and self.State ~= "Aim" then
				self:SetAnimationState("Aim")
			end

			if aimTime and not self.IsAiming then
				self.IsAiming = true
				character:AimingStarted()
			end

			if currentTargetIsTower then
				self:FaceTower(currentTarget)
			else
				self:FaceEnemy(currentTarget)
			end

			self.TimeSinceLastHadTarget = 0
		elseif currentHealTarget then
			if healing and self.State ~= "Healing" then
				self:SetAnimationState("Healing")
			end

			self:FaceTower(currentHealTarget)
			character:RunDefaultBeamEffects(true, currentHealTarget.Character)
		else
			self.TimeSinceLastHadTarget += p

			if aim and self.TimeSinceLastHadTarget >= levelStats.AimTime and self.State == "Aim" then
				self:SetAnimationState("Idle")
			end

			if self.State == "Healing" then
				self:SetAnimationState("Idle")
			end

			if aimTime and self.IsAiming then
				self.IsAiming = false
				character:AimingStopped()
			end

			if not self.BeamEffectForDefaultAttack then
				character:RunDefaultBeamEffects(false)
			end
		end

		self.TimeAlive += p
	end

	if pylonMovementHandler then
		if not self.HelicopterCrashLocation then
			self:PositionCharacterForPylonMovement(p)
		end
	elseif self:_RotateToFaceTarget() then
		if character:ShouldLerpRotation() then
			character:LerpCFrame(p, self.CFrame, true)
		else
			character:SetCFrame(self.CFrame, true)
		end

		if self.IsAirUnit then
			local position = character:GetTorso().Position
			local x = position.X
			local y = position.Y
			local z = position.Z
			local defaultHoverHeight = character:GetDefaultHoverHeight()
			local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(x, z)
			local v10 = rangeDisplayHeightAtXZ + defaultHoverHeight - 6 < y and 6
				or rangeDisplayHeightAtXZ + defaultHoverHeight - y

			if not (v9 or self.FPSPosition) then
				character:SetHoverHeight(v10, p)
			end
		end
	else
		character:SetCFrame(self.CFrame)
	end

	abilityHandler:Run(p)
	attachmentEntityHandler:Run(p)
	healthHandler:Run(p, DEFAULT_SPEED_MULTIPLIER, character:GetRealTorso())

	if directControlHandler then
		directControlHandler:Run(p)
	end

	character:Run(p)
	character:SetCurrentReloadTimeForTower(self:GetCurrentReloadTime())

	if self.Stealth then
		character:RunStealthShimmer(true)
	else
		character:StopStealthShimmer()
	end

	if self.ClientsideIsBurst then
		self.TimeUntilResetAttackBurstIndex -= p

		if self.TimeUntilResetAttackBurstIndex <= 0 then
			self.AttackBurstIndex = 1
		end
	end

	if self.IsAlive and levelStats.PlacementDisplayDashedRange then
		self:_UpdatePlacementDisplayDashedCircle()
	else
		self:_DestroyPlacementDashedCircle()
	end

	if self.IsAlive then
		if not buffHandler:IsStunned() and (not self.ClientsideIsBurst or self.AttackBurstIndex == 1) then
			self.TimeUntilNextAttack = math.max(0, self.TimeUntilNextAttack - p)
		end

		self.ShieldRefreshCooldown = math.max(0, self.ShieldRefreshCooldown - p)
	end

	if self.ReloadTimeDisplay then
		if self.DisplayShieldRefreshTime then
			local amount = TowerUpgradeShopUtilities.GetAmount(
				self.UpgradeTypeToActiveUpgradeShopData,
				Enums.TowerUpgradeShopTypes.ShieldRegenSpeed
			)
			self.ReloadTimeDisplay:Update(self.ShieldRefreshCooldown, amount * levelStats.ShieldGrantRefreshTime)
		else
			self.ReloadTimeDisplay:Update(self.TimeUntilNextAttack, self:GetCurrentReloadTime())
		end

		if self.Selected or self.UserInputHovered then
			self.ReloadTimeDisplay:Show()
		else
			self.ReloadTimeDisplay:Hide()
		end
	end

	if self.CanRebuild then
		self.RebuildTimeRemaining = math.max(0, self.RebuildTimeRemaining - p)
	end

	if levelStats.DamageDelay then
		self.DamageDelayRemaining -= p

		if self.DamageDelayRemaining <= 0 then
			self.LastAttackedTargetWithDamageDelay = nil
		end
	end

	if self.HelicopterCrashLocation then
		self:_RunHelicopterCrash(p)
	end
end

function TowerClass:_StartHelicopterCrash()
	local helicopterCrashData = self.Config.HelicopterCrashData
	local character = self.Character
	local primaryPart = character:GetCharacterModel().PrimaryPart
	primaryPart.Anchored = true
	character:DestroyTorsoToRootWeld()
	self.InternalHelicopterCrashData = {
		TimeLeft = self.HelicopterCrashDuration,
		TotalTime = self.HelicopterCrashDuration,
		Root = primaryPart,
		StartPosition = primaryPart.Position,
		ExplosionEffectName = helicopterCrashData.ExplosionEffectName
	}
end

function TowerClass:_RunHelicopterCrash(p: number)
	if not self.InternalHelicopterCrashData then
		self:_StartHelicopterCrash()
	end

	local internalHelicopterCrashData = self.InternalHelicopterCrashData
	internalHelicopterCrashData.TimeLeft -= p

	if internalHelicopterCrashData.TimeLeft > 0 then
		local v9 = (internalHelicopterCrashData.TimeLeft / internalHelicopterCrashData.TotalTime) ^ 0.4
		local lerped = internalHelicopterCrashData.StartPosition:Lerp(self.HelicopterCrashLocation, 1 - v9)
		local root = internalHelicopterCrashData.Root
		root.CFrame = CFrame.new(lerped) * root.CFrame.Rotation
	else
		local explosionEffectName = internalHelicopterCrashData.ExplosionEffectName

		if explosionEffectName then
			local v9 = { Name = explosionEffectName, Position = self.HelicopterCrashLocation }
			VisualEffectHandler.NewVisualEffect(v9)
		end

		if self.CanRebuild then
			if self.CustomCode and self.CustomCode.HelicopterCrashFinished then
				self.CustomCode:HelicopterCrashFinished()
			end

			self.Character:RestoreTorsoToRootWeld()
		else
			self.Character:ExplodeParts()
		end

		self.HelicopterCrashLocation = nil
		self.InternalHelicopterCrashData = nil
	end
end

function TowerClass:_UpdatePlacementDisplayDashedCircle()
	local placementDashedCircleData = self.PlacementDashedCircleData

	if v4 and v5 then
		if self.PVPTeamIndex ~= TeamUtilities.GetLocalPlayerTeamIndex() then
			return
		end

		local currentRange = self:GetCurrentRange()
		local position = self:GetPosition()
		local v9

		if (Vector3.new(position.X, 0, position.Z) - Vector3.new(v5.X, 0, v5.Z)).Magnitude <= currentRange + v6 then
			v9 = color2
		else
			v9 = color
		end

		if placementDashedCircleData and currentRange == placementDashedCircleData.Radius then
			DashedCircleUtilities.UpdateCircleColor(placementDashedCircleData, v9)
			DashedCircleUtilities.ShowCircle(placementDashedCircleData)
		else
			self:_DestroyPlacementDashedCircle()
			local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
			self.PlacementDashedCircleData = DashedCircleUtilities.NewDashedCircleData(
				Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z),
				currentRange,
				v9,
				0.1
			)
		end
	elseif placementDashedCircleData then
		DashedCircleUtilities.HideCircle(placementDashedCircleData)
	end
end

function TowerClass:_DestroyPlacementDashedCircle()
	if self.PlacementDashedCircleData then
		DashedCircleUtilities.DestroyCircle(self.PlacementDashedCircleData)
		self.PlacementDashedCircleData = nil
	end
end

function TowerClass:_DestroyAbilityDashedCircle()
	if self.AbilityDashedCircleData then
		DashedCircleUtilities.DestroyCircle(self.AbilityDashedCircleData)
		self.AbilityDashedCircleData = nil
	end
end

function TowerClass:_DestroyDeadzoneDashedCircle()
	if self.DeadzoneDashedCircleData then
		DashedCircleUtilities.DestroyCircle(self.DeadzoneDashedCircleData)
		self.DeadzoneDashedCircleData = nil
	end
end

function TowerClass:GetPosition()
	return self.CFrame.Position
end

function TowerClass:SetPosition(position: Vector3)
	self.CFrame = CFrame.new(position) * self.CFrame.Rotation
	event2:Fire(self.Hash)
end

function TowerClass:GetTorsoPosition()
	return self.Character:GetRealTorso().Position
end

function TowerClass:GetCurrentRange()
	local levelStats = self.LevelHandler:GetLevelStats()
	local statMultipliers = self.BuffHandler:GetStatMultipliers()
	local mainAttackOverrideData = self:GetMainAttackOverrideData()
	local range = mainAttackOverrideData and mainAttackOverrideData.Range or levelStats.Range
	local v9 = (1 + statMultipliers.RangeMultiplier) * range
	local upgradeTypeToActiveUpgradeShopData = self.UpgradeTypeToActiveUpgradeShopData

	if upgradeTypeToActiveUpgradeShopData then
		return v9 * TowerUpgradeShopUtilities.GetAmount(
			upgradeTypeToActiveUpgradeShopData,
			Enums.TowerUpgradeShopTypes.Range
		)
	end

	return v9
end

function TowerClass.GetCurrentMinRange(p)
	local levelStats = p.LevelHandler:GetLevelStats()

	if levelStats.MinRange > 0 then
		return levelStats.MinRange
	end
end

function TowerClass:GetCurrentReloadTime()
	local levelStats = self.LevelHandler:GetLevelStats()
	local statMultipliers = self.BuffHandler:GetStatMultipliers()
	local mainAttackOverrideData = self:GetMainAttackOverrideData()
	local reloadTime = mainAttackOverrideData and mainAttackOverrideData.ReloadTime or levelStats.ReloadTime
	local v9 = 1 / (1 + statMultipliers.FirerateMultiplier) * reloadTime
	local upgradeTypeToActiveUpgradeShopData = self.UpgradeTypeToActiveUpgradeShopData

	if upgradeTypeToActiveUpgradeShopData then
		return v9 * TowerUpgradeShopUtilities.GetAmount(
			upgradeTypeToActiveUpgradeShopData,
			Enums.TowerUpgradeShopTypes.Firerate
		)
	end

	return v9
end

function TowerClass:GetCurrentSplashRadius()
	local levelStats = self.LevelHandler:GetLevelStats()
	local mainAttackOverrideData = self:GetMainAttackOverrideData()
	local splashRadius = mainAttackOverrideData and mainAttackOverrideData.SplashRadius or levelStats.SplashRadius
	local v9 = levelStats.IsSplash and splashRadius

	if not v9 then
		return nil
	end

	local upgradeTypeToActiveUpgradeShopData = self.UpgradeTypeToActiveUpgradeShopData

	if upgradeTypeToActiveUpgradeShopData then
		return v9 * TowerUpgradeShopUtilities.GetAmount(
			upgradeTypeToActiveUpgradeShopData,
			Enums.TowerUpgradeShopTypes.Splash
		)
	end

	return v9
end

function TowerClass:GetBeamDuration()
	return self.BeamEffectDuration or 2 * self:GetCurrentReloadTime()
end

function TowerClass:_AdjustAttackAnimationSpeed()
	local levelStats = self.LevelHandler:GetLevelStats()

	if
		levelStats.ProjectileName
		and ResourceManager.GetProjectileConfig(levelStats.ProjectileName).AnimationTriggerTime
	then
		self.Character:SetAttackAnimationSpeed(1)
		return
	end

	local amount = TowerUpgradeShopUtilities.GetAmount(
		self.UpgradeTypeToActiveUpgradeShopData,
		Enums.TowerUpgradeShopTypes.Firerate
	)
	self.Character:SetAttackAnimationSpeed(self.AttackAnimationSpeedMultiplier / amount)
end

function TowerClass:IncrementQueryType()
	self.QueryTypeIndex += 1
	self:_QueryTypeChanged()
end

function TowerClass:DecrementQueryType()
	self.QueryTypeIndex -= 1
	self:_QueryTypeChanged()
end

function TowerClass:_QueryTypeChanged()
	local customQueryOptions = self.CustomQueryOptions

	if customQueryOptions then
		self.QueryTypeIndex %= #customQueryOptions
	else
		self.QueryTypeIndex %= QueryType.GetQueryTypeCount()
	end

	self:_UpdateManualAimRetargetState()
	event19:FireServer(self.Hash, self.QueryTypeIndex)
end

function TowerClass:SetQueryTypeIndex(queryTypeIndex: number)
	self.QueryTypeIndex = queryTypeIndex
	self:_UpdateManualAimRetargetState()
end

function TowerClass:IsManualAiming()
	if not self.ManualAimPosition then
		return false
	end

	if not self.ManualAimingAllowAutoTargeting then
		return true
	end

	local customQueryOptions = self.CustomQueryOptions
	return customQueryOptions ~= nil and customQueryOptions[self.QueryTypeIndex + 1] == QueryType.Manual
end

function TowerClass:_UpdateManualAimRetargetState()
	if not self.ManualAimingAllowAutoTargeting then
		return
	end

	local isManualAiming = self:IsManualAiming()
	self.AbilityHandler:SetManualAimRetargetDisabled(not isManualAiming)

	if isManualAiming and self.ManualAimPosition then
		self:FacePosition(self.ManualAimPosition, nil, true)
	end
end

function TowerClass:FacePosition(lastFacePosition: Vector3, p: number?, flag: boolean?)
	if not flag and self:IsManualAiming() then
		return
	end

	if self:_RotateToFaceTarget() then
		local position = self.CFrame.Position
		local vector = Vector3.new(lastFacePosition.X, position.Y, lastFacePosition.Z)

		if (vector - position).Magnitude > 0.001 then
			self.CFrame = CFrame.new(position, vector)

			if not self.Character:ShouldLerpRotation() then
				self.Character:SetCFrame(self.CFrame, true)
			end
		end

		if self.HasTurret then
			self.Character:AimTurretAtPosition(lastFacePosition, p, self.AimAllTurretsForAttack)
		end
	elseif self.HasTurret then
		self.Character:AimTurretAtPosition(lastFacePosition, p, self.AimAllTurretsForAttack)
	end

	self.LastFacePosition = lastFacePosition
end

function TowerClass:FaceEnemy(object, p: number?)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPathPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function TowerClass:FaceTower(object, p: number?)
	if object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function TowerClass:SetAnimationState(state: string, flag: boolean?)
	if not (self.IsAlive or flag) then
		return
	end

	if state == "VictoryDance" then
		self.CurrentTarget = nil
	end

	self.State = state
	self.Character:SetAnimationState(state)
end

function TowerClass:CancelAnimationStateIfEquals(p: string)
	if self.State == p then
		self:SetAnimationState("Idle")
	end
end

function TowerClass.IsConverted(p)
	return p.Converted
end

function TowerClass:Alive()
	return self.IsAlive
end

function TowerClass.Selectable(p)
	return p.IsAlive or p.CanRebuild
end

function TowerClass:SetAlive(data)
	local isAlive = data.IsAlive
	local overkill = data.Overkill
	local canRebuild = data.CanRebuild
	local rebuildTime = data.RebuildTime
	local rebuildsLeft = data.RebuildsLeft
	local _fromInstantKill = data.FromInstantKill
	local instantKillType = data.InstantKillType
	local helicopterCrashLocation = data.HelicopterCrashLocation
	local helicopterCrashDuration = data.HelicopterCrashDuration
	self.IsAlive = isAlive

	if canRebuild ~= nil then
		self.CanRebuild = canRebuild
		self.RebuildTime = rebuildTime
		self.RebuildsLeft = rebuildsLeft
	end

	local primaryAnimationHandler = self.Character.PrimaryAnimationHandler

	if isAlive then
		if primaryAnimationHandler then
			if primaryAnimationHandler:GetAnimation("Revive") then
				self:SetAnimationState("Revive")
			else
				self:SetAnimationState("Idle")
			end
		end

		if self.Reviving then
			self.Character:TowerRevived()
			self.Reviving = false
		else
			self.Character:TowerRebuilt()
		end

		if self.CustomCode and self.CustomCode.Rebuilt then
			self.CustomCode:Rebuilt()
		end
	else
		local config = self.Config

		if primaryAnimationHandler then
			if instantKillType and primaryAnimationHandler:GetAnimation("Death" .. instantKillType) then
				self:SetAnimationState("Death" .. instantKillType, true)
			elseif self.BuffHandler:IsOnFire() and primaryAnimationHandler:GetAnimation("DeathBurn") then
				self:SetAnimationState("DeathBurn", true)
			elseif overkill and primaryAnimationHandler:GetAnimation("DeathOverkill") then
				self:SetAnimationState("DeathOverkill", true)
			elseif primaryAnimationHandler:GetAnimation("DeathStart") then
				self:SetAnimationState("DeathStart", true)
			elseif primaryAnimationHandler:GetAnimation("Death") then
				self:SetAnimationState("Death", true)
			else
				local v9 = false

				for k in primaryAnimationHandler.Animations do
					if not string.find(k, "Death") then
						continue
					end

					v9 = true
					break
				end

				if not (v9 or canRebuild) then
					self.Character:TowerTemporaryDeathStuff(config.NoDefaultDeathEffect)
				end
			end
		elseif not canRebuild then
			self.Character:TowerTemporaryDeathStuff(config.NoDefaultDeathEffect)
		end

		if helicopterCrashLocation then
			if config.HelicopterCrashData then
				self.HelicopterCrashLocation = helicopterCrashLocation
				self.HelicopterCrashDuration = helicopterCrashDuration
			else
				warn("HelicopterCrashData not found for tower type " .. self.Type)
			end
		end

		self.AbilityHandler:StopEffects()
		self.BuffHandler:RemoveAllBuffs()
		self.HealthHandler:Death()

		if canRebuild then
			self.Character:SetTowerRebuilding()
			self.RebuildTimeRemaining = rebuildTime
		else
			self.Character:TowerDeath(instantKillType)
			event:Fire(self.Hash)
		end

		if self.CustomCode then
			self.CustomCode:Death()
		end
	end
end

function TowerClass:SetTowerReviving()
	self.Character:SetTowerReviving()
end

function TowerClass:_RenderProjectileForAttack(object, flag: boolean?)
	local levelStats = self.LevelHandler:GetLevelStats()
	local attackProjectileConfig = self.AttackProjectileConfig
	local position = object:GetPosition()

	if attackProjectileConfig.NoPhysicalProjectile then
		if flag then
			self:FaceTower(object)
		else
			self:FaceEnemy(object)
		end
	else
		local burnEffectStats = levelStats.BurnEffectStats
		local name, duration

		if burnEffectStats then
			name = burnEffectStats.Name
			duration = burnEffectStats.Duration
		end

		local overrideGoalPosition = nil

		if levelStats.IsPiercing and not object:GetIsAirUnit() then
			local range = levelStats.Range
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
			OriginEntityClass = "Tower",
			TargetEntityClass = flag and "Tower" or "Enemy",
			OriginHash = self.Hash,
			TargetHash = object.Hash,
			TimeToHit = timeToHitForRangedProjectile,
			OverrideGoalPosition = overrideGoalPosition,
			FaceTarget = true,
			ProjectileConfig = attackProjectileConfig,
			BurstIndex = self:_GetAttackBurstIndex(),
			SkinModelData = self.Character:GetSkinModelData(),
			BurnEffectName = name,
			BurnEffectDuration = duration
		}
		ProjectileHandler.NewProjectile(v9)
	end
end

function TowerClass:_RenderProjectileForAttackPosition(vector: Vector3)
	local attackProjectileConfig = self.AttackProjectileConfig

	if attackProjectileConfig.NoPhysicalProjectile then
		self:FacePosition(vector)
		return
	end

	local timeToHitForRangedProjectile = ProjectileUtilities.GetTimeToHitForRangedProjectile(
		self.CFrame.Position,
		vector,
		attackProjectileConfig
	)
	local v9 = {
		OriginEntityClass = "Tower",
		TargetEntityClass = "Enemy",
		OriginHash = self.Hash,
		TimeToHit = timeToHitForRangedProjectile,
		OverrideGoalPosition = vector,
		FaceTarget = true,
		ProjectileConfig = attackProjectileConfig,
		BurstIndex = self:_GetAttackBurstIndex(),
		SkinModelData = self.Character:GetSkinModelData()
	}
	ProjectileHandler.NewProjectile(v9)
end

function TowerClass:_HandleRenderHitEffect(object, vector: Vector3?)
	if not (object or vector) then
		warn("No goal position could be determined for rendering hit effect")
		return
	end

	if self.Character:GetCharacterModel():GetAttribute("NoHitEffect") then
		return
	end

	local levelStats = self.LevelHandler:GetLevelStats()
	local clientHitEffectData = levelStats.ClientHitEffectData

	if not clientHitEffectData then
		return
	end

	if self.AttackIsProjectile then
		warn("Projectile with ClientHitEffectData detected. Set hit effects in the projectile instead")
		return
	end

	local v9 = vector
		or (clientHitEffectData.TargetTorsoInsteadOfGround or object:GetIsAirUnit()) and object:GetTorsoPosition()
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
		Delay = clientHitEffectData.Delay or levelStats.DamageDelay
	}
	VisualEffectHandler.NewVisualEffect(v10)
end

function TowerClass:Attack(lastAttackedTargetWithDamageDelay, flag: boolean?, list)
	if self.AttackIsProjectile then
		self:_RenderProjectileForAttack(lastAttackedTargetWithDamageDelay, flag)
	elseif flag then
		self:FaceTower(lastAttackedTargetWithDamageDelay)
	else
		self:FaceEnemy(lastAttackedTargetWithDamageDelay)
	end

	local levelStats = self.LevelHandler:GetLevelStats()
	local statMultipliers = self.BuffHandler:GetStatMultipliers()
	local damageDelayRemaining

	if levelStats.DamageDelay then
		self.LastAttackedTargetWithDamageDelay = lastAttackedTargetWithDamageDelay
		self.DamageDelayRemaining = levelStats.DamageDelay / (1 + statMultipliers.FirerateMultiplier)
		damageDelayRemaining = self.DamageDelayRemaining
	end

	if self.CustomCode then
		self.CustomCode:Attacked(lastAttackedTargetWithDamageDelay, flag)
	end

	self:Attacked()
	self:_HandleRenderHitEffect(lastAttackedTargetWithDamageDelay)

	if self.BeamEffectForDefaultAttack then
		local characters

		if list then
			characters = {}

			for _, v9 in ipairs(list) do
				table.insert(characters, v9.Character)
			end
		end

		self.Character:RunDefaultBeamEffects(
			true,
			lastAttackedTargetWithDamageDelay.Character,
			self:GetBeamDuration(),
			damageDelayRemaining,
			characters
		)
	end
end

function TowerClass:ChainAttack(list, flag: boolean?)
	if self.AttackIsProjectile then
		warn("Chain attack with projectiles not implemented")
		return
	end

	local v9 = {}
	local v10 = {}

	for i, v11 in ipairs(list) do
		local v12 = flag and TowerClass.GetTower(v11) or EnemyClass.GetEnemy(v11)

		if v12 then
			table.insert(v9, v12)

			if i > 1 then
				table.insert(v10, v12)
			end
		elseif flag then
			print("TowerClass:ChainAttack: Tower with hash", v11, "does not exist")
		else
			print("TowerClass:ChainAttack: Enemy with hash", v11, "does not exist")
		end
	end

	local v11 = v9[1]

	if not v11 then
		return
	end

	self:Attack(v11, flag, v10)
end

function TowerClass:AttackPosition(vector: Vector3)
	if self.AttackIsProjectile then
		self:_RenderProjectileForAttackPosition(vector)
	else
		self:FacePosition(vector)
	end

	self:Attacked()
	self:_HandleRenderHitEffect(nil, vector)
end

function TowerClass:TriggerAttackFromProjectileHandler(vector: Vector3, p: number?)
	self:FacePosition(vector, p)
	self:Attacked()
end

function TowerClass.IsRebuilding(p)
	return p.RebuildTimeRemaining > 0
end

function TowerClass.IsReviving(p)
	return p.Reviving
end

function TowerClass:_GetAttackAnimation()
	local attackBurstIndex = self:_GetAttackBurstIndex()
	local character = self.Character
	local primaryAnimationHandler = character.PrimaryAnimationHandler
	local v9 = nil

	if primaryAnimationHandler then
		if self.SpecialBurstHandlingForModel or character:GetOverrideBurstSize() then
			v9 = primaryAnimationHandler.Animations["Attack" .. tostring(attackBurstIndex)]
		end

		return v9 or primaryAnimationHandler.Animations.Attack
	end

	return v9
end

function TowerClass:Attacked()
	local character = self.Character
	local primaryAnimationHandler = character.PrimaryAnimationHandler
	local attackAnimation = self:_GetAttackAnimation()

	if attackAnimation then
		local flag = false

		if
			self.NoRestartAttackAnimationIfPlaying
			and not character.IgnoreNoRestartAttackAnimationIfPlaying
			and primaryAnimationHandler:GetState() == attackAnimation.Name
		then
			if self.CanPlayAttackAnimationAgain then
				attackAnimation:SetPlayAgainWhenFinished()
			end
		else
			flag = true
		end

		if flag then
			self:SetAnimationState(attackAnimation.Name)
		end
	end

	character:Attacked(self:_GetAttackBurstIndex())
	self:_BurstAttackHandling()
	self.TimeUntilNextAttack = self:GetCurrentReloadTime()
end

function TowerClass:_GetAttackBurstIndex()
	if self.ClientsideIsBurst then
		return self.AttackBurstIndex
	end
end

function TowerClass:_BurstAttackHandling()
	if self.ClientsideIsBurst then
		self.AttackBurstIndex += 1

		if self.AttackBurstIndex > self.ClientsideBurstSize then
			self.AttackBurstIndex = 1
		end

		self.TimeUntilResetAttackBurstIndex = 2 * self.ClientsideBurstInterval
	end
end

function TowerClass:TargetChanged(p: number, currentTargetIsTower: boolean?)
	if p == 0 then
		self.CurrentTarget = nil
		return
	end

	local currentTarget = currentTargetIsTower and TowerClass.GetTower(p) or EnemyClass.GetEnemy(p)

	if not currentTarget then
		warn(`Tower TargetChanged: {currentTargetIsTower and "Tower" or "Enemy"} doesn't exist`)
		return
	end

	self.CurrentTarget = currentTarget
	self.CurrentTargetIsTower = currentTargetIsTower
end

function TowerClass:HealTargetChanged(p: number)
	if p == 0 then
		self.CurrentHealTarget = nil
		return
	end

	local tower = TowerClass.GetTower(p)

	if tower then
		self.CurrentHealTarget = tower
	else
		warn("Tower HealTargetChanged: Tower doesn't exist with hash", p)
	end
end

function TowerClass.IsDestroyed(p)
	return p.Destroyed
end

function TowerClass:Destroy(flag: boolean?)
	local ownerName = self.OwnerName
	event:Fire(self.Hash)

	if self.Type == Enums.Towers.EDJ then
		EDJMusicHandler.EDJRemoved(self, v)
	end

	self:_DestroyPlacementDashedCircle()
	self:_DestroyAbilityDashedCircle()
	self:_DestroyDeadzoneDashedCircle()

	if self.ReloadTimeDisplay then
		self.ReloadTimeDisplay:Destroy()
	end

	self.BuffHandler:RemoveAllBuffs()
	self.HealthHandler:Death()
	v2[self.Character:GetTorso()] = nil
	self.Character:Destroy(flag)
	v[self.Hash] = nil
	v3 -= 1

	if self.OwnedByLocalPlayer then
		stats:TowerRemoved(self.Type)
	end

	if self.IsAirUnit and not self.Config.IgnoreAirPlacementLimit then
		v8[ownerName] -= 1
	end

	self.Destroyed = true
end

function TowerClass:SetHealth(p: number)
	self.HealthHandler:SetHealth(p)
end

function TowerClass:SetMaxHealth(p: number)
	self.HealthHandler:SetMaxHealth(p)
end

function TowerClass:SetShield(p: number)
	self.HealthHandler:SetShield(p)
end

function TowerClass:SetMaxShield(p: number)
	self.HealthHandler:SetMaxShield(p)
end

function TowerClass:SetHasSharedShield(flag: boolean)
	self.HealthHandler:SetHasSharedShield(flag)
end

function TowerClass:SetHasDirectShield(flag: boolean)
	self.HealthHandler:SetHasDirectShield(flag)
end

function TowerClass:ShieldRefreshed(shieldRefreshCooldown: number)
	self.ShieldRefreshCooldown = shieldRefreshCooldown

	if self.CustomCode.TriggerShieldRefresh then
		self.CustomCode:TriggerShieldRefresh()
	end
end

function TowerClass:Select()
	self.Selected = true
	self.Character:Select()
	local abilityConfigs = self.AbilityHandler:GetAbilityConfigs()
	local v9 = nil

	for _, abilityConfig in pairs(abilityConfigs) do
		if not (abilityConfig.HasRadiusEffect and abilityConfig.EffectRadius) then
			continue
		end

		v9 = abilityConfig
		break
	end

	if v9 then
		local abilityDashedCircleData = self.AbilityDashedCircleData

		if not abilityDashedCircleData or v9.EffectRadius ~= abilityDashedCircleData then
			self:_DestroyAbilityDashedCircle()
			local position = self:GetPosition()
			local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
			self.AbilityDashedCircleData = DashedCircleUtilities.NewDashedCircleData(
				Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z),
				v9.EffectRadius,
				color3,
				0.15
			)
		end
	else
		self:_DestroyAbilityDashedCircle()
	end

	local minRange = self.LevelHandler:GetLevelStats().MinRange

	if minRange and minRange > 0 then
		local deadzoneDashedCircleData = self.DeadzoneDashedCircleData

		if not deadzoneDashedCircleData or minRange ~= deadzoneDashedCircleData.Radius then
			self:_DestroyDeadzoneDashedCircle()
			local position = self:GetPosition()
			local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
			self.DeadzoneDashedCircleData = DashedCircleUtilities.NewDashedCircleData(
				Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z),
				minRange,
				DEADZONE_DASHED_CIRCLE_COLOR,
				0.15
			)
		end
	else
		self:_DestroyDeadzoneDashedCircle()
	end
end

function TowerClass:Deselect()
	self.Selected = false
	self.Character:Deselect()
	self:_DestroyAbilityDashedCircle()
	self:_DestroyDeadzoneDashedCircle()
end

function TowerClass:Upgrade(data)
	local totalCost = data.TotalCost
	local levelReplicationData = data.LevelReplicationData
	local pylonMovementInitData = data.PylonMovementInitData
	self.TotalCost = totalCost
	local character = self.Character
	local v9 = levelReplicationData[1]
	local v10 = levelReplicationData[2]
	local levelHandler = self.LevelHandler
	levelHandler:Upgraded(v9, v10)
	local levelStats = self.LevelHandler:GetLevelStats()
	self.HealthHandler:LevelStatsChanged(levelStats)
	self.AbilityHandler:LevelStatsChanged(levelStats)

	if levelStats.HasDirectControl then
		if not self.DirectControlHandler then
			self.DirectControlHandler = DirectControlHandlerClass.New(levelStats)
			self.DirectControlHandler:SetTower(self)
		end

		self.DirectControlHandler:LevelStatsChanged(levelStats)
	else
		self.DirectControlHandler = nil
	end

	local upgrade = character:Upgrade(levelHandler)
	self.HasTurret = character:HasTurret()

	if upgrade.ResetToSpawnCFrame then
		self.CFrame = self.SpawnCFrame
		character:MarkNextCFrameAsWorldFixedBase()
		character:SetCFrame(self.CFrame, true)
	elseif self.HasTurret and not self.IsAirUnit then
		self.CFrame = self.SpawnCFrame
		character:MarkNextCFrameAsWorldFixedBase()
		character:SetCFrame(self.CFrame, true)

		if self.LastFacePosition then
			self:FacePosition(self.LastFacePosition)
		end
	end

	if levelStats.ShipData and upgrade.ModelChanged then
		self.ShipHandler = ShipHandlerClass.New(
			self.Hash,
			levelStats,
			character,
			levelStats.ShipData,
			DEFAULT_SPEED_MULTIPLIER
		)
	end

	if levelStats.AviatorMovementConfig and self.PylonMovementHandler then
		self.PylonMovementHandler:LevelStatsChanged(levelStats)
	elseif levelStats.PylonMovementConfig then
		if self.PylonMovementHandler then
			self.PylonMovementHandler:LevelStatsChanged(levelStats)
		elseif pylonMovementInitData then
			self.PylonMovementHandler = PylonMovementHandlerClass.New(levelStats, pylonMovementInitData)
			self:PositionCharacterForPylonMovement(0, true)
			self:_PositionRingForPylonMovement()
		else
			warn("Missing PylonMovementInitData")
		end
	else
		self.PylonMovementHandler = nil
	end

	local clientsideIsBurst = levelStats.ClientsideIsBurst
	self.ClientsideIsBurst = character:GetOverrideBurstSize() or clientsideIsBurst or levelStats.IsBurst
	self.ClientsideBurstSize = character:GetOverrideBurstSize()
		or clientsideIsBurst and levelStats.ClientsideBurstSize
		or levelStats.BurstSize
	self.ClientsideBurstInterval = character:GetOverrideBurstInterval()
		or clientsideIsBurst and levelStats.ClientsideBurstInterval
		or levelStats.BurstInterval
	self.AttackBurstIndex = 1
	self:_AdjustAttackAnimationSpeed()
	self.BuffHandler:CharacterModelChanged()
	self.AttachmentEntityHandler:CharacterModelChanged()
	local isProjectile = levelStats.IsProjectile
	local projectileName = isProjectile and levelStats.ProjectileName
	self.AttackIsProjectile = isProjectile
	self.AttackProjectileConfig = isProjectile and ResourceManager.GetProjectileConfig(projectileName)
	self.TimeUntilNextAttack = math.min(self:GetCurrentReloadTime(), self.TimeUntilNextAttack)

	if levelStats.DisableManualAiming then
		self.ManualAimPosition = nil
	end

	if self:IsManualAiming() then
		self:FacePosition(self.ManualAimPosition, nil, true)
	end

	self.AbilityHandler:SetTower(self)

	if self.CustomCode then
		self.CustomCode:Upgraded(levelStats)
		self.AbilityHandler:SetCustomCode(self.CustomCode)
	end

	self.IsBurning = false
	self:_HandleBurnState()
	self:_HandleOverlayPartState()
	self.OverrideUseMovingRangeCircle = levelStats.OverrideUseMovingRangeCircle
	self.HasBeamEffectForDefaultAttack = character:HasBeamEffectForDefaultAttack()
	self.AttackNoFaceTarget = character:GetAttackNoFaceTarget()
	local amount = TowerUpgradeShopUtilities.GetAmount(
		self.UpgradeTypeToActiveUpgradeShopData,
		Enums.TowerUpgradeShopTypes.ShieldRegenSpeed
	)
	self.ShieldRefreshCooldown = math.min(self.ShieldRefreshCooldown, amount * levelStats.ShieldGrantRefreshTime)
	event2:Fire(self.Hash, true)
end

function TowerClass:_HandleBurnState()
	local isOnFire = self.BuffHandler:IsOnFire()

	if self.IsBurning or not isOnFire then
		if self.IsBurning and not isOnFire then
			self.Character:StopBurn()
			self.IsBurning = false
		end
	else
		self.Character:StartBurn()
		self.IsBurning = true
	end
end

function TowerClass:_HandleOverlayPartState()
	if self.IsAlive then
		local character = self.Character
		local buffHandler = self.BuffHandler

		if buffHandler:IsUbered() then
			character:ApplyCharacterOverlayPartConfig(CHARACTER_OVERLAYS.UBER_CHARACTER_OVERLAY_CONFIG)
		elseif buffHandler:IsFrozen() then
			character:ApplyCharacterOverlayPartConfig(CHARACTER_OVERLAYS.ICE_CHARACTER_OVERLAY_CONFIG)
		else
			character:RemoveCharacterOverlayParts()
		end

		if buffHandler:IsFrozen() then
			character:Freeze()
		else
			character:Thaw()
		end
	end
end

function TowerClass:IncreaseDamageDealt(p: number)
	self.DamageDealt += p
end

function TowerClass:IncreaseCashEarned(p: number)
	self.CashEarned += p
	event2:Fire(self.Hash)
end

function TowerClass:IncreaseHealingDealt(p: number)
	self.HealingDealt += p
end

function TowerClass:SetSpawnTimers(spawnTimersPaused: boolean, list)
	local spawnTimers = {}

	for _, v9 in ipairs(list) do
		local v10 = {
			PathEntityType = v9[1],
			TimeToNextSpawn = v9[2],
			Interval = v9[3],
			AliveCount = v9[4],
			MaximumCount = 0,
			MidBurst = 0
		}
		local maximumCount

		if v9[5] > 0 then
			maximumCount = v9[5] or nil
		end

		v10.MaximumCount = maximumCount
		v10.MidBurst = v9[6]
		table.insert(spawnTimers, v10)
	end

	self.SpawnTimers = spawnTimers
	self.SpawnTimersPaused = spawnTimersPaused
end

function TowerClass.GetSpawnTimer(p, p2: string)
	for _, spawnTimer in ipairs(p.SpawnTimers) do
		if spawnTimer.PathEntityType == p2 then
			return spawnTimer
		end
	end

	return nil
end

function TowerClass:GetAbilityFromIndex(p: number)
	return self.AbilityHandler:GetAbilityFromIndex(p)
end

function TowerClass:UseAbility(p: number)
	self.AbilityHandler:UseAbility(p)
end

function TowerClass:ApplyBuffData(p)
	self.BuffHandler:ApplyBuffData(p, self.IsAlive)
end

function TowerClass:RemoveBuffData(p)
	self.BuffHandler:RemoveBuffData(p)
end

function TowerClass:ApplyCustomBuffData(p)
	self.BuffHandler:ApplyCustomBuffData(p)
end

function TowerClass:RemoveCustomBuffData(p)
	self.BuffHandler:RemoveCustomBuffData(p)
end

function TowerClass:AbilityUsedOnServer(p)
	local v9 = nil

	if self.AbilityHandler then
		v9 = self.AbilityHandler:AbilityUsedOnServer(p)

		if self.CustomCode then
			self.CustomCode:AbilityUsed(v9)
			return v9
		end
	else
		warn("Tower used ability but doesn't have ability handler")
	end

	return v9
end

function TowerClass:AbilityCancelledOnServer(p)
	if self.AbilityHandler then
		self.AbilityHandler:AbilityCancelledOnServer(p)
	else
		warn("Tower used ability but doesn't have ability handler")
	end
end

function TowerClass:SetManualAimPosition(manualAimPosition: Vector3)
	self.ManualAimPosition = manualAimPosition
	self:FacePosition(manualAimPosition, nil, true)
	event2:Fire(self.Hash)
end

function TowerClass:AimProjectileTurret(p: string, p2, vector: Vector3)
	self.Character:AimProjectileTurret(p, p2, vector)
end

function TowerClass:SetAttackDisabled(attackDisabled: boolean, flag: boolean?)
	if self.AttackDisabled == attackDisabled then
		return
	end

	self.AttackDisabled = attackDisabled
	local primaryAnimationHandler = self.Character.PrimaryAnimationHandler

	if attackDisabled then
		if not flag and self.AttackDisabledAnimation then
			self.Character:SetAnimationState(self.AttackDisabledAnimation)
		end

		if primaryAnimationHandler then
			primaryAnimationHandler:ResetDefaultStateOverride()
		end
	elseif primaryAnimationHandler and self.AttackEnabledDefaultAnimation then
		primaryAnimationHandler:OverrideDefaultState(self.AttackEnabledDefaultAnimation)
	end
end

function TowerClass.IsStealth(p)
	return p.Stealth
end

function TowerClass:SetStealth(stealth: boolean)
	self.Stealth = stealth
end

function TowerClass:GetGroundPositionForAirUnit(p: number, p2: number)
	local defaultHoverHeight = self.Character:GetDefaultHoverHeight()
	local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(p, p2)
	local minMaxHeight = MapHandler.GetMinMaxHeight()
	local airUnitMaxHeight = MapHandler.GetAirUnitMaxHeight()
	return (Vector3.new(
		p,
		math.max(
			math.min(
				PlacementHandler.GetGroundHeightAtXZ(
					p,
					p2,
					math.max(rangeDisplayHeightAtXZ, self.GoalPosition and self.GoalPosition.Y or -1e999),
					2 * defaultHoverHeight,
					airUnitMaxHeight
				),
				airUnitMaxHeight - defaultHoverHeight
			),
			minMaxHeight
		),
		p2
	))
end

function TowerClass:SetPositionForAirUnit(p: number, p2: number)
	self.GoalPosition = self:GetGroundPositionForAirUnit(p, p2)
	self.FPSPosition = nil
end

function TowerClass:PositionCharacterForPylonMovement(p: number, flag: boolean?)
	local pylonMovementHandler = self.PylonMovementHandler
	local character = self.Character
	pylonMovementHandler:Run(p, self.IsAlive, self.AbilityHandler.Stunned)
	self.CFrame = pylonMovementHandler:GetGoalCFrame()

	if flag or not character:ShouldLerpRotation() then
		character:SetCFrame(self.CFrame, true, self:_ShouldNotMoveRing())
	else
		character:LerpCFrame(p, self.CFrame, true, self:_ShouldNotMoveRing())
	end

	character:SetTorsoToRootWeldRotation(pylonMovementHandler:GetPortCFrame())
end

function TowerClass:_PositionRingForPylonMovement()
	local centerPosition = self.PylonMovementHandler:GetCenterPosition()
	self.Character:SetRingPosition(self:GetGroundPositionForAirUnit(centerPosition.X, centerPosition.Z))
end

function TowerClass:_ShouldNotMoveRing()
	if self.PylonMovementHandler then
		return true
	end

	return false
end

function TowerClass:SetRotation(p: number)
	self.SpawnCFrame = CFrame.new(self.SpawnCFrame.Position) * CFrame.Angles(0, p, 0)
	self.CFrame = self.SpawnCFrame
	self.Character:MarkNextCFrameAsWorldFixedBase()
	self.Character:SetCFrameUsingRoot(self.CFrame)
	event2:Fire(self.Hash)
end

function TowerClass:GetIsAirUnit()
	return self.IsAirUnit
end

function TowerClass:_RotateToFaceTarget()
	if self.HasTurret and not self.IsAirUnit then
		return false
	end

	return not self.PylonMovementHandler and not self.AttackNoFaceTarget
end

function TowerClass:NewAttachmentEntity(p)
	local attachmentEntityHandler = self.AttachmentEntityHandler
	local hash = p.Hash
	local projectile = ProjectileHandler.FindProjectileWithAttachmentEntityHash(hash)

	if projectile then
		projectile:EntitySpawned()
	end

	attachmentEntityHandler:Create(p, projectile)
end

function TowerClass:RemoveAttachmentEntity(p)
	self.AttachmentEntityHandler:Remove(p)
end

function TowerClass.GetDynamicPriceScalingData(p)
	return v7[p.OwnerName] or {}
end

function TowerClass:StartDirectControl(p)
	local directControlHandler = self.DirectControlHandler

	if not directControlHandler then
		warn("Client TowerClass:StartDirectControl: DirectControlHandler not found")
		return
	end

	directControlHandler:Start()
	self.FPSPosition = self.GoalPosition
	self.Character:ToggleFPSParts(false, p.HideCharacterModel)
	self.Character:SetParent(fpsParts)
	event49:FireServer(self.Hash, true)
end

function TowerClass:StopDirectControl()
	local directControlHandler = self.DirectControlHandler

	if not directControlHandler then
		warn("Client TowerClass:StopDirectControl: DirectControlHandler not found")
		return
	end

	directControlHandler:Stop()
	self.GoalPosition = self.FPSPosition
	self.FPSPosition = nil

	if not self.Destroyed then
		self.Character:ToggleFPSParts(true)
		self.Character:SetParent(towers)
	end

	event49:FireServer(self.Hash, false)
end

function TowerClass.DirectControlIsActive(p)
	return p.DirectControlHandler and p.DirectControlHandler:IsActive() or false
end

function TowerClass:FirstPersonAttacked(flag: boolean)
	if not flag then
		self:Attacked()
	end
end

function TowerClass.FirstPersonHitEnemies(p, p2: number, items, vector: Vector3, p3: number?, p4: number?, p5: number?)
	local uniqueIds = {}

	for _, item in pairs(items) do
		table.insert(uniqueIds, item.UniqueId)
	end

	event51:FireServer(
		p.Hash,
		p2,
		uniqueIds,
		vector,
		p3,
		LocalPlayer:GetAttribute("TDX"),
		workspace:GetServerTimeNow(),
		p4,
		p5
	)
end

function TowerClass.FirstPersonMissInDirection(p, vector: Vector3)
	event52:FireServer(p.Hash, vector)
end

function TowerClass.FirstPersonFireProjectile(p, p2, vector: Vector3, p3: number, p4: number?, p5: number?)
	event53:FireServer(p.Hash, p2 and p2.UniqueId or false, vector, p3, workspace:GetServerTimeNow(), p4, p5)
end

function TowerClass.SetFirstPersonIndex(p, p2: number)
	event54:FireServer(p.Hash, p2)
end

function TowerClass:FirstPersonMoveTo(fpsPosition: Vector3, flag: boolean)
	self.FPSPosition = fpsPosition

	if flag then
		event55:FireServer(self.Hash, fpsPosition)
	end
end

function TowerClass.GetCurrentFPSPosition(p)
	return p.FPSPosition
end

function TowerClass:SetFPSPosition(fpsPosition: Vector3)
	if self.OwnedByLocalPlayer then
		warn("Should not be called if owned by local player")
	end

	self.FPSPosition = fpsPosition
end

function TowerClass:FirstPersonAttackedPosition(_: number, vector: Vector3)
	if self.OwnedByLocalPlayer then
		warn("Should not be called if owned by local player")
	end

	self:AttackPosition(vector)
end

function TowerClass:FirstPersonAttackedMiss(_: number, vector: Vector3)
	if self.OwnedByLocalPlayer then
		warn("Should not be called if owned by local player")
	end

	self:AttackPosition(self.Character:GetTorso().CFrame.Position + 1000 * vector.Unit)
end

function TowerClass:FirstPersonNewProjectile(p: string, p2, vector: Vector3, p3: number)
	if self.OwnedByLocalPlayer then
		warn("Should not be called if owned by local player")
	end

	local projectileConfig = ResourceManager.GetProjectileConfig(p)
	local timeToHit = p3 - workspace:GetServerTimeNow()

	if timeToHit < 0 then
		return
	end

	local v9 = {
		OriginEntityClass = "Tower",
		TargetEntityClass = "Enemy",
		OriginHash = self.Hash,
		TargetHash = p2 and p2.Hash,
		ForceTrackCharacter = p2 ~= nil,
		OverrideGoalPosition = not p2 and vector,
		TimeToHit = timeToHit,
		FaceTarget = true,
		ProjectileConfig = projectileConfig,
		SkinModelData = self.Character:GetSkinModelData()
	}
	ProjectileHandler.NewProjectile(v9)
end

function TowerClass.ShouldShowRangeCircle(p)
	local config = p.Config
	return not (config.RangeDisabled or config.UseMovingRangeCircle)
end

function TowerClass.CanShowDashedCircle(data)
	if data.DirectControlHandler and data.DirectControlHandler:IsActive() then
		return false
	end

	return data.UserInputHovered or data.Selected
end

function TowerClass.GetDamageMultiplier(p)
	return p.DamageMultiplier or 1
end

function TowerClass:SetDamageMultiplier(damageMultiplier: number)
	local levelStats = self.LevelHandler:GetLevelStats()
	self.DamageMultiplier = damageMultiplier

	if self.DamageMultiplierScalesEffects then
		local damageIncreaseOverTimeMaxMultiplier = levelStats.DamageIncreaseOverTimeMaxMultiplier or 2
		local v9 = math.clamp((self.DamageMultiplier - 1) / (damageIncreaseOverTimeMaxMultiplier - 1), 0, 1)
		self.Character:ScaleAttackEffects(v9 * 0.8 + 1, v9 * 1.8 + 1)
	end

	if self.Selected then
		event5:Fire(self.Hash)
	end
end

function TowerClass:UpgradeShopDataChanged(p: string?)
	local owner = self.Owner

	if not owner then
		warn("TowerClass:UpgradeShopDataChanged: Owner player wrapper not found")
		return
	end

	local upgradeTypeToActiveUpgradeShopData = owner.UpgradeShopDataHandler:GetUpgradeTypeToActiveUpgradeShopData(self.Type)
	self.UpgradeTypeToActiveUpgradeShopData = upgradeTypeToActiveUpgradeShopData

	for k, _ in pairs(upgradeTypeToActiveUpgradeShopData) do
		if not (not p or p == k) then
			continue
		end

		local v9 = k and TowerUpgradeShopUtilities.GetUpgradeShopTypeData(k)
		local v10 = false
		local v11 = false

		if v9 then
			local count = 0

			if v9.AffectsAbilityHandler then
				count += 1
				v11 = true
			end

			if count == 0 then
				v10 = true
			end
		else
			v10 = true
		end

		if (v10 or v11) and self.AbilityHandler then
			self.AbilityHandler:UpgradeShopDataChanged(upgradeTypeToActiveUpgradeShopData)
		end

		if k == Enums.TowerUpgradeShopTypes.Range then
			event2:Fire(self.Hash, true)
		end

		if k == Enums.TowerUpgradeShopTypes.Firerate then
			self:_AdjustAttackAnimationSpeed()
		end
	end

	if self.Selected then
		event5:Fire(self.Hash)
	end
end

function TowerClass.GetUpgradeShopMultiplier(p, p2: string)
	return TowerUpgradeShopUtilities.GetAmount(p.UpgradeTypeToActiveUpgradeShopData, p2)
end

function TowerClass:GetMainAttackOverrideData()
	return self.MainAttackOverrideData
end

function TowerClass:SetMainAttackOverrideData(mainAttackOverrideData)
	self.MainAttackOverrideData = mainAttackOverrideData
	event2:Fire(self.Hash)
end

function TowerClass:Initialize()
	v7 = self
	event3:AttachCallback(function()
		for _, v9 in pairs(v) do
			v9.Character:RemoveRing()
		end
	end)
	event4:AttachCallback(function(p: number?)
		for _, v9 in pairs(v) do
			if not (not p or v9.Hash == p) then
				continue
			end

			for _, ability in pairs(v9.AbilityHandler.Abilities) do
				ability.CooldownRemaining = 0
			end
		end
	end)
	event6:AttachCallback(function(p: string, p2: string?, p3: string?)
		for _, v9 in pairs(v) do
			if p == v9.OwnerPlayerWrapperKey and (not p2 or p2 == v9.Type) then
				v9:UpgradeShopDataChanged(p3)
			end
		end
	end)
	event7:AttachCallback(function(items)
		for _, item in pairs(items) do
			if item.Creation then
				TowerClass.New(item.Data[1], item.Data[2])
			else
				local v9 = item.Data[1]
				local v10 = item.Data[2]
				local v11 = v[v9]

				if v11 then
					v11:Destroy(v10)
				else
					print("Didn't find tower to remove with hash " .. tostring(v9))
				end
			end
		end
	end)
	event8:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
			local v11 = v[decompressDoubleHash]

			if v11 then
				v11:TargetChanged(v10)
			else
				print("TowerTargetChangedEvent: Tower doesn't exist with hash", decompressDoubleHash)
				break
			end
		end
	end)
	event9:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
			local v11 = v[decompressDoubleHash]

			if v11 then
				v11:TargetChanged(v10, true)
			else
				print("TowerConvertedTargetChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event10:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
			local v11 = v[decompressDoubleHash]

			if v11 then
				v11:HealTargetChanged(v10)
			else
				print("TowerHealTargetChangedEvent: Tower doesn't exist with hash", decompressDoubleHash)
				break
			end
		end
	end)
	event11:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
			local v11 = v[decompressDoubleHash]
			local enemy = EnemyClass.GetEnemy(v10)

			if not v11 then
				print("TowerAttackEvent: Tower doesn't exist")
				break
			end

			if enemy then
				v11:Attack(enemy)
			else
				print("TowerAttackEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event12:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressDoubleHash, v10 = NetworkingUtilities.DecompressDoubleHash(v9)
			local v11 = v[decompressDoubleHash]
			local v12 = v[v10]

			if not v11 then
				print("TowerConvertedAttackEvent: Tower doesn't exist")
				break
			end

			if v12 then
				v11:Attack(v12, true)
			else
				print("TowerConvertedAttackEvent: Target tower doesn't exist")
				break
			end
		end
	end)
	event13:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local v10 = v9[1]
			local v11 = v9[2]
			local v12 = v[v10]

			if v12 then
				v12:ChainAttack(v11)
			else
				print("TowerChainAttackEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event14:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local v10 = v9[1]
			local v11 = v9[2]
			local v12 = v[v10]

			if v12 then
				v12:ChainAttack(v11, true)
			else
				print("TowerConvertedChainAttackEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event15:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local v10 = v9[1]
			local v11 = v9[2]
			local v12 = v[v10]

			if v12 then
				v12:AttackPosition(v11)
			else
				print("TowerAttackPositionEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event16:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local v10 = v9[1]
			local v11 = v9[2]
			local v12 = v[v10]

			if v12 then
				local abilityUsedOnServer = v12:AbilityUsedOnServer(v11)
				local animationName = abilityUsedOnServer and abilityUsedOnServer:GetAnimationName()

				if animationName then
					v12:SetAnimationState(animationName)
				end
			else
				print("TowerAbilityUsedEvent: Tower doesn't exist")
			end
		end
	end)
	event17:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local v10 = v9[1]
			local v11 = v9[2]
			local v12 = v[v10]

			if v12 then
				v12:AbilityCancelledOnServer(v11)
			else
				print("TowerAbilityCancelledEvent: Tower doesn't exist")
			end
		end
	end)
	event18:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local v10 = v9[1]
			local v11 = v9[2]
			local v12 = v9[3]
			local v13 = v[v10]

			if v13 then
				v13:SetAnimationState(v11)

				if v12 then
					v13:FacePosition(v12)
				end

				if v13.AbilityHandler then
					v13.AbilityHandler:SetAnimationStateChanged(v11)
				end
			else
				print("Tower AnimationStateChangedEvent: Tower doesn't exist")
			end
		end
	end)
	event21:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = v[item.Hash]

			if v9 then
				v9:Upgrade(item)
			else
				print("TowerUpgradeQueueUpdatedEvent: Tower doesn't exist")
			end
		end
	end)
	event22:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v9 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v10 = v[decompressHashAndInteger]

			if v10 then
				v10:SetHealth(v9)
			end
		end
	end)
	event23:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v9 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v10 = v[decompressHashAndInteger]

			if v10 then
				v10:SetMaxHealth(v9)
			end
		end
	end)
	event24:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v9 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v10 = v[decompressHashAndInteger]

			if v10 then
				v10:SetShield(v9)
			end
		end
	end)
	event25:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v9 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v10 = v[decompressHashAndInteger]

			if v10 then
				v10:SetMaxShield(v9)
			end
		end
	end)
	event26:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v9 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v10 = v[decompressHashAndInteger]

			if v10 then
				v10:SetHasSharedShield(v9 == 1)
			end
		end
	end)
	event27:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndInteger, v9 = NetworkingUtilities.DecompressHashAndInteger(item)
			local v10 = v[decompressHashAndInteger]

			if v10 then
				v10:SetHasDirectShield(v9 == 1)
			end
		end
	end)
	event28:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndNumber1Place, v9 = NetworkingUtilities.DecompressHashAndNumber1Place(item)
			local v10 = v[decompressHashAndNumber1Place]

			if v10 then
				v10:ShieldRefreshed(v9)
			end
		end
	end)
	event29:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(v9)
			local v11 = v[decompressHashAndInteger]

			if v11 then
				v11:IncreaseDamageDealt(v10)
			else
				print("TowerDamageDealtChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event31:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local v10 = v[v9[1]]

			if not v10 then
				continue
			end

			local v11 = v9[2]
			v10:SetSpawnTimers(v11[1], v11[2])
		end
	end)
	event30:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(v9)
			local v11 = v[decompressHashAndInteger]

			if v11 then
				v11:IncreaseCashEarned(v10)
			else
				print("TowerCashEarnedChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event32:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(v9)
			local v11 = v[decompressHashAndInteger]

			if v11 then
				v11:IncreaseHealingDealt(v10)
			else
				print("TowerHealingDealtChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event33:AttachCallback(function(items)
		for _, item in pairs(items) do
			local towerHash = item.TowerHash
			local v9 = v[towerHash]

			if v9 then
				v9:ApplyBuffData(item)
			else
				print("Didn't find tower with hash " .. tostring(towerHash) .. " to apply buff data to")
			end
		end
	end)
	event34:AttachCallback(function(items)
		for _, item in pairs(items) do
			local towerHash = item.TowerHash
			local v9 = v[towerHash]

			if v9 then
				v9:RemoveBuffData(item)
			else
				print("Didn't find tower with hash " .. tostring(towerHash) .. " to remove buff data from")
			end
		end
	end)
	event35:AttachCallback(function(items)
		for _, item in pairs(items) do
			local towerHash = item.TowerHash
			local v9 = v[towerHash]

			if v9 then
				v9:ApplyCustomBuffData(item)
			else
				print("Didn't find tower with hash " .. tostring(towerHash) .. " to apply custom buff data to")
			end
		end
	end)
	event36:AttachCallback(function(items)
		for _, item in pairs(items) do
			local towerHash = item.TowerHash
			local v9 = v[towerHash]

			if v9 then
				v9:RemoveCustomBuffData(item)
			else
				print("Didn't find tower with hash " .. tostring(towerHash) .. " to remove custom buff data from")
			end
		end
	end)
	event37:AttachCallback(function(p: number, p2: number, p3: number, p4: number, flag: boolean)
		local v9 = v[p]

		if not v9 then
			print("ShipTurretFiredEvent: Tower doesn't exist")
			return
		end

		if not v9.IsShip then
			print("ShipTurretFiredEvent: Tower is not a ship")
			return
		end

		local shipHandler = v9.ShipHandler
		local v10

		if flag then
			v10 = TowerClass.GetTower(p4)
		else
			v10 = EnemyClass.GetEnemy(p4)
		end

		if v10 then
			shipHandler:Attack(p2, p3, v10, flag)
		else
			print(`ShipTurretFiredEvent: {flag and "Tower" or "Enemy"} doesn't exist`)
		end
	end)
	event20:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressDoubleHash, v9 = NetworkingUtilities.DecompressDoubleHash(item)
			local v10 = v[decompressDoubleHash]

			if v10 then
				if not v10.OwnedByLocalPlayer then
					v10:SetQueryTypeIndex(v9)
				end
			else
				print("TowerQueryTypeIndexChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event38:AttachCallback(function(p)
		local v9 = v[p.Hash]

		if not v9 then
			return
		end

		v9:SetAlive(p)
	end)
	event39:AttachCallback(function(p: number, vector: Vector3)
		local v9 = v[p]

		if v9 then
			v9:SetManualAimPosition(vector)
		else
			print("Tower: Tower doesn't exist")
		end
	end)
	event40:AttachCallback(function(p: number, p2: number)
		local v9 = v[p]

		if v9 then
			v9:SetRotation(p2)
		else
			print("Tower: Tower doesn't exist")
		end
	end)
	event41:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressDoubleHash, v9 = NetworkingUtilities.DecompressDoubleHash(item)
			local v10 = v9 == 1
			local v11 = v[decompressDoubleHash]

			if v11 then
				v11:SetAttackDisabled(v10)
			else
				print("TowerQueryTypeIndexChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event42:AttachCallback(function(list)
		for _, v9 in ipairs(list) do
			local decompressHashAndInteger, v10 = NetworkingUtilities.DecompressHashAndInteger(v9)
			local v11 = v10 == 1
			local v12 = v[decompressHashAndInteger]

			if v12 then
				v12:SetStealth(v11)
			else
				print("TowerStealthStatusChangedEvent: Enemy doesn't exist")
				break
			end
		end
	end)
	event43:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = item[1]
			local v10 = item[2]
			local v11 = v[v9]

			if v11 then
				v11:SetPositionForAirUnit(v10.X, v10.Y)
			else
				print("TowerAirUnitPositionChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event44:AttachCallback(function(items, p: number)
		local v9 = (workspace:GetServerTimeNow() - p) * DEFAULT_SPEED_MULTIPLIER

		for _, item in pairs(items) do
			local v10 = v[item[1]]
			local pylonMovementHandler = v10 and v10.PylonMovementHandler

			if not (pylonMovementHandler and pylonMovementHandler.ApplyServerSync) then
				continue
			end

			local stunned = v10.AbilityHandler.Stunned
			pylonMovementHandler:ApplyServerSync(item[2], item[3], stunned and 0 or v9)
		end
	end)
	event45:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = item[1]
			local v10 = item[2]
			local v11 = v[v9]

			if v11 then
				v11:SetPosition(v10)
			else
				print("TowerPositionChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event46:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = item[1]
			local v10 = item[2]
			local v11 = v[v9]

			if v11 then
				VisualEffectHandler.HandleVisualEffectOnEntity(v11.Character, v10)
			else
				print("TowerVisualEffectEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event47:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = item[1]
			local v10 = item[2]
			local v11 = v[v9]

			if not v11 then
				print("TowerNewAttachmentEntityEvent: Tower doesn't exist")
				break
			end

			for _, v12 in pairs(v10) do
				if v12.Creation then
					v11:NewAttachmentEntity(v12.Data)
				else
					v11:RemoveAttachmentEntity(v12.Data)
				end
			end
		end
	end)
	event48:AttachCallback(function(flag: boolean?, list)
		if not flag then
			v7 = list
			return
		end

		local v9 = list[1]
		local v10 = list[2]
		local v11 = list[3]

		if not v7[v9] then
			v7[v9] = {}
		end

		v7[v9][v10] = v11
	end)
	event50:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = v[item]

			if v9 then
				v9:SetAnimationState("Reload")
			else
				print("TowerStartReloadEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event56:AttachCallback(function(list)
		local v9 = list[1]
		local v10 = list[2]
		local v11 = list[3]
		local v12 = v[v10]

		if v12 then
			v12:FirstPersonAttackedPosition(v9, v11)
		else
			print("TowerFirstPersonAttackHitEvent: Tower doesn't exist")
		end
	end)
	event57:AttachCallback(function(list)
		local v9 = list[1]
		local v10 = list[2]
		local v11 = list[3]
		local v12 = v[v10]

		if v12 then
			v12:FirstPersonAttackedMiss(v9, v11)
		else
			print("TowerFirstPersonAttackMissEvent: Tower doesn't exist")
		end
	end)
	event58:AttachCallback(function(list)
		local v9 = list[1]
		local v10 = list[2]
		local v11 = list[3]
		local v12 = list[4]
		local v13 = list[5]
		local v14 = v[v9]

		if v14 then
			v14:FirstPersonNewProjectile(v10, v11 and EnemyClass.GetEnemyByUniqueId(v11), v12, v13)
		else
			print("TowerFirstPersonAttackProjectileEvent: Tower doesn't exist")
		end
	end)
	event59:AttachCallback(function(list)
		local v9 = list[1]
		local v10 = list[2]
		local v11 = v[v9]

		if v11 then
			v11:SetFPSPosition(v10)
		else
			print("TowerFirstPersonMovedEvent: Tower doesn't exist")
		end
	end)
	event60:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndNumber1Place, v9 = NetworkingUtilities.DecompressHashAndNumber1Place(item)
			local v10 = v[decompressHashAndNumber1Place]
			local v11 = v9 / 100

			if v10 then
				v10:SetDamageMultiplier(v11)
			else
				print("TowerDamageMultiplierChangedEvent: Tower doesn't exist")
				break
			end
		end
	end)
	event61:AttachCallback(function(p)
		local hash = p.Hash
		local reviving = p.Reviving
		local v9 = v[hash]

		if not v9 then
			return
		end

		if not reviving then
			v9.Reviving = false
			return
		end

		v9.Reviving = true
		v9:SetTowerReviving()
	end)
	event62:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = item[1]
			local v10 = item[2]
			local v11 = v[v9]

			if v11 then
				v11:SetMainAttackOverrideData(v10)
			else
				print("TowerMainAttackOverrideChangedEvent: Tower doesn't exist")
			end
		end
	end)
end

return TowerClass