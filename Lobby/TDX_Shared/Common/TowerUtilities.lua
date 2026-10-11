local TowerUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("TowerBuffUtilities"))
local SkinHandler = require(common:WaitForChild("SkinHandler"))
local BaseRigMethodHandler = require(common:WaitForChild("BaseRigMethodHandler"))
local Utilities = require(common:WaitForChild("Utilities"))

local function GetAbilityConfigs(abilityNames)
	local result = {}

	for _, v in pairs(abilityNames or {}) do
		table.insert(result, ResourceManager.GetTowerAbilityConfig(v))
	end

	return result
end

local function AddStats(state, list, p: number)
	for i = 1, p do
		local v = list[i]
		state.TotalCost += v.Cost
		state.Damage += v.DamageIncrease or 0
		state.ReloadTime -= v.ReloadTimeDecrease or 0
		state.Range += v.RangeIncrease or 0

		if v.HealthIncrease then
			state.Health += v.HealthIncrease
		end

		if v.GainUntargetable then
			state.Untargetable = true
		end

		if v.CashPerWaveIncrease then
			if not state.CashPerWave then
				state.CashPerWave = 0
			end

			state.CashPerWave += v.CashPerWaveIncrease
		end

		if v.CashPerCompletedBurstIncrease and state.CashPerCompletedBurst ~= nil then
			state.CashPerCompletedBurst += v.CashPerCompletedBurstIncrease
		end

		if v.DisplayCashEarned then
			state.DisplayCashEarned = true
		end

		if v.CashPerTickOverride then
			state.CashPerTick = v.CashPerTickOverride
		end

		if v.CashTickDurationOverride then
			state.CashTickDuration = v.CashTickDurationOverride
		end

		if v.CashPerDamageMultiplierIncrease then
			state.CashPerDamageMultiplier += v.CashPerDamageMultiplierIncrease
		end

		if v.GoldWinBonusOverride then
			state.GoldWinBonus = v.GoldWinBonusOverride
		end

		if v.SlowSpeedIncrease then
			state.SlowSpeed += v.SlowSpeedIncrease
		end

		if v.MiniBossSlowSpeedIncrease then
			state.BossSlowSpeed += v.MiniBossSlowSpeedIncrease
		end

		if v.GainStealthDetection then
			state.StealthDetection = true
		end

		if v.GainStunImmunity then
			state.StunImmunity = true
		end

		if state.IsBurst then
			state.BurstSize += v.BurstSizeIncrease or 0
		end

		if v.RemoveBurst then
			state.IsBurst = false
		end

		if v.ArcSpreadAngleIncrease and not state.IsArc then
			state.IsArc = true
		end

		if state.IsArc then
			state.ArcMaximumRadians += math.rad(v.ArcSpreadAngleIncrease or 0)
			state.ArcMaximumTargetsHit += v.ArcMaximumTargetsHitIncrease or 0
		end

		if v.SplashRadiusIncrease and not state.IsSplash then
			state.IsSplash = true
		end

		if state.IsSplash then
			state.SplashRadius += v.SplashRadiusIncrease or 0

			if v.SplashMaximumTargetsHitOverride then
				state.SplashMaximumTargetsHit = v.SplashMaximumTargetsHitOverride
			else
				state.SplashMaximumTargetsHit += v.SplashMaximumTargetsHitIncrease or 0
			end
		end

		if v.RemoveSplash then
			state.IsSplash = false
			state.SplashHasBeenRemoved = true
		end

		if state.IsIceDamage then
			state.BodyHeatReduction += v.BodyHeatReductionIncrease or 0
			state.PermanentSpeedMultiplierIfFrozen += v.PermanentSpeedMultiplierIfFrozenIncrease or 0
			state.DamageMultiplierIfFrozen += v.DamageMultiplierIfFrozenIncrease or 0
			state.ThawTimeIfFrozen += v.ThawTimeIfFrozenIncrease or 0
			state.IgnoreIceResistance = state.IgnoreIceResistance or v.IgnoreIceResistance
			state.CanFreezeBoss = state.CanFreezeBoss or v.CanFreezeBoss
			state.FrozenEnemyDamageMultiplier += v.FrozenEnemyDamageMultiplierIncrease or 0
		end

		if state.NearbyTowerFirerateBuff then
			state.NearbyTowerFirerateBuff += v.NearbyTowerFirerateBuffIncrease or 0
		end

		if state.NearbyTowerRangeBuff then
			state.NearbyTowerRangeBuff += v.NearbyTowerRangeBuffIncrease or 0
		end

		if state.NearbyTowerDamageBuff then
			state.NearbyTowerDamageBuff += v.NearbyTowerDamageBuffIncrease or 0
		end

		if state.NearbyTowerDiscount then
			state.NearbyTowerDiscount += v.NearbyTowerDiscountIncrease or 0
		end

		if state.NearbyTowerSellback then
			state.NearbyTowerSellback += v.NearbyTowerSellbackIncrease or 0
		end

		if state.NearbyTowerDeathCashback then
			state.NearbyTowerDeathCashback += v.NearbyTowerDeathCashbackIncrease or 0
		end

		if state.NearbyTowerHealPerSecond then
			state.NearbyTowerHealPerSecond += v.NearbyTowerHealPerSecondIncrease or 0
		end

		if v.PierceCountIncrease then
			state.IsPiercing = true
			state.PierceCount += v.PierceCountIncrease
		end

		if v.NoDisplayPierceCount then
			state.NoDisplayPierceCount = true
		end

		if v.StaticEntityLifetimeIncrease then
			if state.StaticEntityLifetime then
				state.StaticEntityLifetime += v.StaticEntityLifetimeIncrease
			else
				warn("LevelStats.StaticEntityLifetime was nil")
			end
		end

		if v.DamageType then
			state.DamageType = v.DamageType
		end

		if v.GainIgnoreResistance then
			state.IgnoreResistance = true
		end

		if v.RemoveIgnoreResistance then
			state.IgnoreResistance = false
		end

		if v.RemoveSpawnPathEntityNames then
			local spawnPathEntityData = {}

			for _, v2 in pairs(state.SpawnPathEntityData) do
				if not table.find(v.RemoveSpawnPathEntityNames, v2.PathEntityType) then
					table.insert(spawnPathEntityData, v2)
				end
			end

			state.SpawnPathEntityData = spawnPathEntityData
		end

		if v.AddSpawnPathEntityData then
			for _, v2 in pairs(v.AddSpawnPathEntityData) do
				table.insert(state.SpawnPathEntityData, v2)
			end
		end

		if v.ReduceSpawnPathEntityInterval then
			state.SpawnPathEntityIntervalReduction += v.ReduceSpawnPathEntityInterval
		end

		if v.DisableManualAiming then
			state.DisableManualAiming = true
		end

		if v.StunType then
			state.StunType = v.StunType
		end

		if v.StunDurationIncrease then
			state.StunDuration += v.StunDurationIncrease

			if not state.StunType then
				warn("StunType was not set")
			end
		end

		if v.GainCanStunBoss then
			state.CanStunBoss = true
		end

		if v.SlowdownPercentageIncrease then
			state.SlowdownPercentage += v.SlowdownPercentageIncrease
		end

		if v.SlowdownDurationIncrease then
			state.SlowdownDuration += v.SlowdownDurationIncrease
		end

		if v.KnockbackStudsOverride then
			state.KnockbackStuds = v.KnockbackStudsOverride
		end

		if v.KnockbackRiseTimeOverride then
			state.KnockbackRiseTime = v.KnockbackRiseTimeOverride
		end

		if v.KnockbackFallTimeOverride then
			state.KnockbackFallTime = v.KnockbackFallTimeOverride
		end

		if v.KnockbackSuspendTimeOverride then
			state.KnockbackSuspendTime = v.KnockbackSuspendTimeOverride
		end

		if v.KnockbackBuffNameOverride then
			state.KnockbackBuffName = v.KnockbackBuffNameOverride
		end

		if v.KnockbackSuspendEffectNameOverride then
			state.KnockbackSuspendEffectName = v.KnockbackSuspendEffectNameOverride
		end

		if v.DisableBossKnockbackOverride ~= nil then
			state.DisableBossKnockback = v.DisableBossKnockbackOverride
		end

		if v.DisableMiniBossKnockbackOverride ~= nil then
			state.DisableMiniBossKnockback = v.DisableMiniBossKnockbackOverride
		end

		if v.GainPlacementDisplayDashedRange then
			state.PlacementDisplayDashedRange = true
		end

		local burnEffectStats = state.BurnEffectStatsUpgradable and state.BurnEffectStats

		if burnEffectStats then
			if v.BurnEffectNameChange then
				burnEffectStats.Name = v.BurnEffectNameChange
			end

			if v.BurnEffectDisplayNameChange then
				burnEffectStats.DisplayName = v.BurnEffectDisplayNameChange
			end

			if v.BurnEffectDamagePerSecondIncrease then
				burnEffectStats.DamagePerSecond += v.BurnEffectDamagePerSecondIncrease
			end

			if v.BurnEffectRadiusIncrease then
				burnEffectStats.Radius += v.BurnEffectRadiusIncrease
			end

			if v.BurnEffectDurationIncrease then
				burnEffectStats.Duration += v.BurnEffectDurationIncrease
			end

			if v.BurnEffectStickDurationIncrease then
				burnEffectStats.StickDuration += v.BurnEffectStickDurationIncrease
			end
		end

		if v.HealAmountIncrease then
			state.HealAmount += v.HealAmountIncrease
		end

		if v.GainStealth then
			state.Stealth = true
		end

		if v.RegainStealthIfRevealed then
			state.RegainStealthIfRevealed = true
		end

		if v.TimeToRegainStealthOverride then
			state.TimeToRegainStealth = v.TimeToRegainStealthOverride
		end

		if v.MovementSpeedIncrease then
			state.MovementSpeed += v.MovementSpeedIncrease
		end

		if v.MaximumROMIncrease then
			state.MaximumROM += v.MaximumROMIncrease
		end

		if v.MaximumROMOverride then
			state.MaximumROM = v.MaximumROMOverride
		end

		if v.RemoveMaximumROM then
			state.MaximumROM = nil
		end

		if v.GainCanTargetAir then
			state.CanTargetAir = true
		end

		if v.SplashAlwaysHitAirAndGround then
			state.SplashAlwaysHitAirAndGround = true
		end

		if v.BaitEnemyAttacks then
			state.BaitEnemyAttacks = true
		end

		if v.ExtraDamageMultiplierIncrease then
			state.ExtraDamageMultiplier += v.ExtraDamageMultiplierIncrease
		end

		if v.ExtraDamageMultiplierBossIncrease then
			state.ExtraDamageMultiplierBoss += v.ExtraDamageMultiplierBossIncrease
		end

		if v.ExtraDamageDurationIncrease then
			state.ExtraDamageDuration += v.ExtraDamageDurationIncrease
		end

		if v.HasDirectControl then
			state.HasDirectControl = true
		end

		if v.DirectControlMagSizeIncrease then
			state.DirectControlMagSize += v.DirectControlMagSizeIncrease
		end

		if v.DirectControlReloadTimeDecrease then
			state.DirectControlReloadTime -= v.DirectControlReloadTimeDecrease
		end

		if v.ShieldSharedGrantIncrease then
			state.ShieldSharedGrant += v.ShieldSharedGrantIncrease
		end

		if v.ShieldSharedGrantRemove then
			state.ShieldSharedGrant = 0
		end

		if v.ShieldDirectGrantIncrease then
			state.ShieldDirectGrant += v.ShieldDirectGrantIncrease
		end

		if v.ShieldGrantRefreshTimeDecrease then
			state.ShieldGrantRefreshTime -= v.ShieldGrantRefreshTimeDecrease
		end

		if v.GainIgnoreObstacles then
			state.IgnoreObstacles = true
		end

		if v.ChainCountIncrease then
			state.ChainCount += v.ChainCountIncrease
		end

		if v.ChainMaxDistanceIncrease then
			state.ChainMaxDistance += v.ChainMaxDistanceIncrease
		end

		if v.ChainDamageMultiplierIncrease then
			state.ChainDamageMultiplier += v.ChainDamageMultiplierIncrease
		end

		if state.ReviveDuration then
			state.ReviveDuration -= v.ReviveDurationDecrease or 0
		end
	end
end

local function ApplyOverrideStats(p, data)
	if data.OverrideReloadTime then
		p.ReloadTime = data.OverrideReloadTime
		p.ReloadTimeHasBeenOverriden = true
	end

	if data.OverrideBodyHeatReduction then
		p.BodyHeatReduction = data.OverrideBodyHeatReduction
	end

	if data.OverrideBurnEffectDuration then
		p.BurnEffectStats.Duration = data.OverrideBurnEffectDuration
	end

	if data.OverrideBurnEffectMaximumTargetsHit then
		p.BurnEffectStats.MaximumTargetsHit = data.OverrideBurnEffectMaximumTargetsHit
	end

	if data.OverrideBurnEffectEnemyBuffNames then
		p.BurnEffectStats.EnemyBuffNames = data.OverrideBurnEffectEnemyBuffNames
	end

	if data.OverrideBurnVFXName then
		p.BurnEffectStats.OverrideBurnVFXName = data.OverrideBurnVFXName
	end

	if data.ClientsideBurstSizeOverride then
		p.ClientsideBurstSize = data.ClientsideBurstSizeOverride
		p.ClientsideIsBurst = true
	end

	if data.ClientsideBurstIntervalOverride then
		p.ClientsideBurstInterval = data.ClientsideBurstIntervalOverride
		p.ClientsideIsBurst = true
	end

	if data.ClientsideRemoveBurst then
		p.ClientsideIsBurst = false
	end

	if data.MinRangeOverride then
		p.MinRange = data.MinRangeOverride
	end

	if data.BurstSizeOverride then
		p.BurstSize = data.BurstSizeOverride
		p.IsBurst = true
	end

	if data.BurstIntervalOverride then
		p.BurstInterval = data.BurstIntervalOverride
		p.IsBurst = true
	end

	if data.DamageDelayOverride then
		p.DamageDelay = data.DamageDelayOverride
	end

	if data.DirectControlMagSizeOverride then
		p.DirectControlMagSize = data.DirectControlMagSizeOverride
	end

	if data.DirectControlReloadTimeOverride then
		p.DirectControlReloadTime = data.DirectControlReloadTimeOverride
	end

	if data.DamageIncreaseOverTimeMaxMultiplierOverride then
		p.DamageIncreaseOverTimeMaxMultiplier = data.DamageIncreaseOverTimeMaxMultiplierOverride
	end

	if data.DamageIncreaseOverTimeDurationOverride then
		p.DamageIncreaseOverTimeDuration = data.DamageIncreaseOverTimeDurationOverride
	end

	if data.DamageIncreaseOverTimeCooldownOverride then
		p.DamageIncreaseOverTimeCooldown = data.DamageIncreaseOverTimeCooldownOverride
	end

	if data.DamageIncreasePerSecondOverride then
		p.DamageIncreasePerSecond = data.DamageIncreasePerSecondOverride
	end

	p.TurretConfigs = data.TurretConfigs
	p.RotatingBarrelData = data.RotatingBarrelData
	p.FirstPersonConfig = data.FirstPersonConfig
	p.PylonMovementConfig = data.PylonMovementConfig
	p.OverrideUseMovingRangeCircle = data.OverrideUseMovingRangeCircle

	if data.AviatorMovementConfig then
		p.AviatorMovementConfig = data.AviatorMovementConfig
	end
end

local function ApplyProjectileData(p, p2) -- 1 equivalent call inferred from this helper
	if p2.ProjectileName then
		p.ProjectileName = p2.ProjectileName
		p.IsProjectile = true
	end

	if p2.RemoveProjectile then
		p.ProjectileName = nil
		p.IsProjectile = false
	end
end

local function HandleIncompatibilityWarnings(data)
	if (data.IsProjectile or data.IsSplash) and data.IsArc then
		warn("LevelStats.IsArc is true, but LevelStats.IsProjectile or LevelStats.IsSplash is true. Arc spread angle will be ignored.")
	end

	if not data.IsSplash and data.PrimaryTargetMultiplier > 1 then
		warn("LevelStats.IsSplash is false, but LevelStats.PrimaryTargetMultiplier is greater than 1. Primary target multiplier will be ignored.")
	end

	if data.AimTime > 0 and data.IsArc then
		warn("LevelStats.AimTime is greater than 0, but LevelStats.IsArc is true. Behavior is undefined.")
	end
end

function TowerUtilities.GetLevelStats(data, p: number, p2: number)
	local baseLevelData = data.BaseLevelData
	local isBurst

	if baseLevelData.BurstSize == nil then
		isBurst = false
	else
		isBurst = baseLevelData.BurstInterval ~= nil
	end

	local clientsideIsBurst

	if baseLevelData.ClientsideBurstSize == nil then
		clientsideIsBurst = false
	else
		clientsideIsBurst = baseLevelData.ClientsideBurstInterval ~= nil
	end

	local isArc = baseLevelData.ArcSpreadAngle ~= nil
	local isIceDamage = baseLevelData.BodyHeatReduction ~= nil
	local buffsNearbyTowers = baseLevelData.NearbyTowerFirerateBuff ~= nil
		or baseLevelData.NearbyTowerRangeBuff ~= nil
		or baseLevelData.NearbyTowerDamageBuff ~= nil
		or baseLevelData.NearbyTowerDiscount ~= nil
		or baseLevelData.NearbyTowerSellback ~= nil
		or baseLevelData.NearbyTowerDeathCashback ~= nil
		or baseLevelData.NearbyTowerHealPerSecond ~= nil
		or baseLevelData.ShieldSharedGrant ~= nil
		or baseLevelData.ShieldDirectGrant ~= nil
	local clone = baseLevelData.SpawnPathEntityData and table.clone(baseLevelData.SpawnPathEntityData)
	local v = {
		TotalCost = baseLevelData.Cost,
		Health = baseLevelData.Health,
		Untargetable = baseLevelData.Untargetable or false,
		CanRebuild = baseLevelData.CanRebuild or false,
		RebuildTime = baseLevelData.RebuildTime or 0,
		RebuildTimeIncreaseEachDeath = baseLevelData.RebuildTimeIncreaseEachDeath or 0,
		HasDirectControl = baseLevelData.HasDirectControl or false,
		DirectControlMagSize = baseLevelData.DirectControlMagSize,
		DirectControlReloadTime = baseLevelData.DirectControlReloadTime,
		IsProjectile = baseLevelData.ProjectileName ~= nil,
		ProjectileName = baseLevelData.ProjectileName,
		TargetRandomLocationOnPath = baseLevelData.TargetRandomLocationOnPath or false,
		SpawnStaticEntityName = baseLevelData.SpawnStaticEntityName,
		DamageStatsTransferredToStaticEntity = baseLevelData.DamageStatsTransferredToStaticEntity or false,
		StaticEntityLifetime = baseLevelData.StaticEntityLifetime,
		SpawnPathEntityData = clone or {},
		SpawnPathEntityIntervalReduction = 0,
		ApplyBurnStats = baseLevelData.ApplyBurnStats,
		BurnEffectStats = baseLevelData.BurnEffectStats,
		BurnEffectStatsUpgradable = baseLevelData.BurnEffectStatsUpgradable,
		CanTargetAir = baseLevelData.CanTargetAir or false,
		IgnoreGround = baseLevelData.IgnoreGround or false,
		AirUnitDamageMultiplier = baseLevelData.AirUnitDamageMultiplier or 1,
		IsPiercing = baseLevelData.PierceCount or false,
		PierceCount = baseLevelData.PierceCount or 0,
		NoDisplayPierceCount = baseLevelData.NoDisplayPierceCount or false,
		IsSplash = baseLevelData.IsSplash or false,
		SplashRadius = baseLevelData.SplashRadius or 0,
		PrimaryTargetMultiplier = baseLevelData.PrimaryTargetMultiplier or 1,
		SplashMaximumTargetsHit = baseLevelData.SplashMaximumTargetsHit or 1e999,
		SplashHasBeenRemoved = false,
		SplashAlwaysHitAirAndGround = baseLevelData.SplashAlwaysHitAirAndGround or false,
		NoAirToGroundSplashTransfer = baseLevelData.NoAirToGroundSplashTransfer or false,
		ReplicateReloadingOverride = nil,
		AimTime = baseLevelData.AimTime or 0,
		AimResetTime = baseLevelData.AimResetTime or 0,
		ResetAimAfterEachShot = false,
		DamageType = baseLevelData.DamageType,
		IgnoreResistance = baseLevelData.IgnoreResistance or false,
		Damage = baseLevelData.Damage,
		DamageDelay = baseLevelData.DamageDelay,
		HealAmount = baseLevelData.HealAmount,
		ReloadTime = baseLevelData.ReloadTime,
		ReloadTimeHasBeenOverriden = false,
		Range = baseLevelData.Range,
		MinRange = baseLevelData.MinRange or 0,
		StealthDetection = baseLevelData.StealthDetection,
		StunImmunity = baseLevelData.StunImmunity or false,
		MovementSpeed = baseLevelData.MovementSpeed or 0,
		MovementDefaultMode = baseLevelData.MovementDefaultMode,
		PylonMovementConfig = baseLevelData.PylonMovementConfig,
		AviatorMovementConfig = baseLevelData.AviatorMovementConfig,
		MaximumROM = baseLevelData.MaximumROM,
		IgnoreObstacles = baseLevelData.IgnoreObstacles or false,
		DamageIncreaseOverTimeMaxMultiplier = baseLevelData.DamageIncreaseOverTimeMaxMultiplier,
		DamageIncreaseOverTimeDuration = baseLevelData.DamageIncreaseOverTimeDuration,
		DamageIncreaseOverTimeCooldown = baseLevelData.DamageIncreaseOverTimeCooldown,
		DamageIncreasePerSecond = baseLevelData.DamageIncreasePerSecond,
		LockOnTarget = baseLevelData.LockOnTarget,
		RetargetCooldown = baseLevelData.RetargetCooldown,
		ChainCount = baseLevelData.ChainCount or 0,
		ChainMaxDistance = baseLevelData.ChainMaxDistance or 0,
		ChainDamageMultiplier = baseLevelData.ChainDamageMultiplier or 0,
		Stealth = baseLevelData.Stealth,
		RegainStealthIfRevealed = baseLevelData.RegainStealthIfRevealed or false,
		TimeToRegainStealth = baseLevelData.TimeToRegainStealth,
		IsIceDamage = isIceDamage,
		BodyHeatReduction = baseLevelData.BodyHeatReduction or 0,
		PermanentSpeedMultiplierIfFrozen = baseLevelData.PermanentSpeedMultiplierIfFrozen or 1,
		DamageMultiplierIfFrozen = baseLevelData.DamageMultiplierIfFrozen or 1,
		ThawTimeIfFrozen = baseLevelData.ThawTimeIfFrozen or _G.DEFAULT_THAW_TIME,
		IgnoreIceResistance = baseLevelData.IgnoreIceResistance or false,
		CanFreezeBoss = baseLevelData.CanFreezeBoss or false,
		FrozenEnemyDamageMultiplier = baseLevelData.FrozenEnemyDamageMultiplier or 1,
		BuffsNearbyTowers = buffsNearbyTowers,
		NearbyTowerFirerateBuff = baseLevelData.NearbyTowerFirerateBuff,
		NearbyTowerRangeBuff = baseLevelData.NearbyTowerRangeBuff,
		NearbyTowerDamageBuff = baseLevelData.NearbyTowerDamageBuff,
		NearbyTowerDiscount = baseLevelData.NearbyTowerDiscount,
		NearbyTowerSellback = baseLevelData.NearbyTowerSellback,
		NearbyTowerDeathCashback = baseLevelData.NearbyTowerDeathCashback,
		NearbyTowerHealPerSecond = baseLevelData.NearbyTowerHealPerSecond,
		BuffUseRange2 = baseLevelData.BuffUseRange2,
		BuffUseDamage2 = baseLevelData.BuffUseDamage2,
		BuffUseDamage3 = baseLevelData.BuffUseDamage3,
		ShieldSharedGrant = baseLevelData.ShieldSharedGrant or 0,
		ShieldDirectGrant = baseLevelData.ShieldDirectGrant or 0,
		ShieldGrantRefreshTime = baseLevelData.ShieldGrantRefreshTime or 0,
		CashPerWave = baseLevelData.CashPerWave,
		DisplayCashEarned = baseLevelData.DisplayCashEarned or false,
		CashPerCompletedBurst = baseLevelData.CashPerCompletedBurst,
		SlowSpeed = baseLevelData.SlowSpeed or 0,
		BossSlowSpeed = baseLevelData.BossSlowSpeed or 0,
		StunType = baseLevelData.StunType,
		StunDuration = baseLevelData.StunDuration or 0,
		CanStunBoss = baseLevelData.CanStunBoss or false,
		ExtraDamageMultiplier = baseLevelData.ExtraDamageMultiplier or 0,
		ExtraDamageMultiplierBoss = baseLevelData.ExtraDamageMultiplierBoss or 0,
		ExtraDamageDuration = baseLevelData.ExtraDamageDuration or 0,
		SlowdownPercentage = baseLevelData.SlowdownPercentage or 0,
		SlowdownDuration = baseLevelData.SlowdownDuration or 0,
		KnockbackStuds = baseLevelData.KnockbackStuds or 0,
		KnockbackHeight = baseLevelData.KnockbackHeight or 0,
		KnockbackRiseTime = baseLevelData.KnockbackRiseTime or 0,
		KnockbackFallTime = baseLevelData.KnockbackFallTime or 0,
		KnockbackSuspendTime = baseLevelData.KnockbackSuspendTime or 0,
		KnockbackBuffName = baseLevelData.KnockbackBuffName,
		KnockbackSuspendEffectName = baseLevelData.KnockbackSuspendEffectName,
		DisableBossKnockback = baseLevelData.DisableBossKnockback or false,
		DisableMiniBossKnockback = baseLevelData.DisableMiniBossKnockback or false,
		IsBurst = isBurst,
		BurstSize = not isBurst and 0 or baseLevelData.BurstSize or 0,
		BurstInterval = not isBurst and 0 or baseLevelData.BurstInterval or 0,
		AlwaysMaintainBurst = baseLevelData.AlwaysMaintainBurst or false,
		BurstEndTriggerFullReload = baseLevelData.BurstEndTriggerFullReload or false,
		BurstNotInterruptable = baseLevelData.BurstNotInterruptable or false,
		BaitEnemyAttacks = baseLevelData.BaitEnemyAttacks or false,
		ClientsideIsBurst = clientsideIsBurst,
		ClientsideBurstSize = not clientsideIsBurst and 0 or baseLevelData.ClientsideBurstSize or 0,
		ClientsideBurstInterval = not clientsideIsBurst and 0 or baseLevelData.ClientsideBurstInterval or 0,
		IsArc = isArc,
		ArcMaximumTargetsHit = baseLevelData.ArcMaximumTargetsHit or 1,
		ArcMaximumRadians = math.rad(baseLevelData.ArcSpreadAngle or 0),
		DisableManualAiming = false,
		TurretConfigs = baseLevelData.TurretConfigs,
		RotatingBarrelData = baseLevelData.RotatingBarrelData,
		FirstPersonConfig = baseLevelData.FirstPersonConfig,
		ClientHitEffectData = baseLevelData.ClientHitEffectData,
		AbilityConfigs = GetAbilityConfigs(baseLevelData.AbilityNames),
		ShipData = baseLevelData.ShipData,
		PlacementDisplayDashedRange = baseLevelData.PlacementDisplayDashedRange,
		OverrideUseMovingRangeCircle = nil,
		Icon = baseLevelData.Icon,
		NoShowDPS = baseLevelData.NoShowDPS or false,
		CashPerTick = baseLevelData.CashPerTick,
		CashTickDuration = baseLevelData.CashTickDuration,
		CashPerDamageMultiplier = baseLevelData.CashPerDamageMultiplier,
		GoldWinBonus = baseLevelData.GoldWinBonus,
		ReviveDuration = baseLevelData.ReviveDuration
	}

	if p == 0 and p2 == 0 then
		return v
	end

	local onePathOnly = data.OnePathOnly
	local v2 = data.Path1Data[p]
	local v3

	if onePathOnly then
		v3 = v2
	else
		v3 = data.Path2Data[p2]

		if p2 <= p then
			v3 = v2 or v3
		end
	end

	v.AbilityConfigs = GetAbilityConfigs(v3.AbilityNames)
	v.Icon = v3.Icon
	v.PrimaryTargetMultiplier = v3.PrimaryTargetMultiplierOverride or 1
	v.AimTime = v3.AimTimeOverride or v.AimTime
	v.AimResetTime = v3.AimResetTimeOverride or v.AimResetTime
	v.ResetAimAfterEachShot = v3.ResetAimAfterEachShot or false
	v.ApplyBurnStats = v3.ApplyBurnStats
	v.ClientHitEffectData = v3.ClientHitEffectData
	v.ShipData = v3.ShipData
	local replicateReloadingOverride

	if v3.ReplicateReloadingOverride == nil then
		replicateReloadingOverride = v.ReplicateReloadingOverride
	else
		replicateReloadingOverride = v3.ReplicateReloadingOverride
	end

	v.ReplicateReloadingOverride = replicateReloadingOverride

	if v.BurnEffectStatsUpgradable then
		v.BurnEffectStats = table.clone(v.BurnEffectStats)
	else
		v.BurnEffectStats = v3.BurnEffectStats
	end

	AddStats(v, data.Path1Data, p)

	if not onePathOnly then
		AddStats(v, data.Path2Data, p2)
	end

	ApplyOverrideStats(v, v3)
	ApplyProjectileData(v, v3) -- inferred equivalent call
	HandleIncompatibilityWarnings(v)
	return v
end

function TowerUtilities.CalculateDPS(data, p, value: number?, p2)
	local damage = p2 and p2.Damage or data.Damage
	local reloadTime = p2 and p2.ReloadTime or data.ReloadTime
	local burstInterval = data.BurstInterval
	local v = not (data.AimTime and data.ResetAimAfterEachShot) and 0 or data.AimTime
	local v2 = damage * data.PrimaryTargetMultiplier
	local v3 = reloadTime * (value or 1)
	local v4 = burstInterval * (value or 1)

	if p then
		local damageMultiplier = p.DamageMultiplier
		local v5 = 1 / (1 + p.FirerateMultiplier)
		v2 *= 1 + damageMultiplier
		v3 *= v5
		v4 *= v5
	end

	if not data.IsBurst then
		return v2 / (v3 + v)
	end

	local burstSize = data.BurstSize
	return burstSize * v2 / ((burstSize - 1) * v4 + v3 + v)
end

function TowerUtilities.CalculateAttackDataDPS(data)
	local damage = data.Damage
	local reloadTime = data.ReloadTime
	local burstSize = data.BurstSize
	local burstInterval = data.BurstInterval

	if data.IsBurst and burstSize and burstInterval then
		return burstSize * damage / ((burstSize - 1) * burstInterval + reloadTime)
	end

	return damage / reloadTime
end

function TowerUtilities.CalculateAttacksDPS(list)
	if not list or #list == 0 then
		return nil
	end

	local total = 0

	for _, v in ipairs(list) do
		total += TowerUtilities.CalculateAttackDataDPS(v)
	end

	return total
end

function TowerUtilities.GetSellReturnRate(flag: boolean?, value: number?)
	if flag then
		return _G.TOWER_SELL_RETURN_CONVERTED
	end

	return _G.TOWER_SELL_RETURN + (value or 0)
end

function TowerUtilities.AppendPathLevelString(p: string, p2: string?)
	if p2 then
		return p .. "_" .. p2
	end

	return p
end

function TowerUtilities.GetViewport(parent, captureTowerName: string, captureSkinName: string?, childName: string?, p: number?, p2: number?, value: number?, flag: boolean?, flag2: boolean?, flag3: boolean?)
	local towerConfig = ResourceManager.GetTowerConfig(captureTowerName)
	local pathLockLevel = towerConfig.UpgradePathData.PathLockLevel
	local v, v2

	if p and p2 then
		v = math.max(p, p2)

		if pathLockLevel <= v then
			if p2 < p then
				v2 = 1
			else
				v2 = 2
			end
		else
			v2 = 1
		end
	else
		v2 = nil
		v = nil
	end

	local function ProcessViewport(instance, flag4: boolean?)
		local overridePath = instance:GetAttribute("OverridePath") or 1
		local overrideLevel = instance:GetAttribute("OverrideLevel") or 0
		local worldModel = instance:FindFirstChildOfClass("WorldModel")
		local model = worldModel and worldModel:FindFirstChildOfClass("Model")

		if model then
			local primaryPart = model.PrimaryPart
			local pivot = model:GetPivot()
			local scale = model:GetScale()
			local cframe = not primaryPart:GetAttribute("ViewportIgnoreCFrameOffset")
				and Utilities.TryReadChildValue(primaryPart, "CFrameOffset")
			local v3 = Utilities.TryReadChildValue(model, "HoverHeight", false)
				or model:GetAttribute("HoverHeight")
				or towerConfig.HoverHeight
				or 1.5 * primaryPart.Size.Y / model:GetScale()
			local viewportScale = model:GetAttribute("ViewportScale")
			local viewportPosition = model:GetAttribute("ViewportPosition")
			local viewportOrientation = model:GetAttribute("ViewportOrientation")
			local v4 = v2 and v2 ~= overridePath
			local v5 = v and v ~= overrideLevel

			if v4 or v5 then
				local towerModel, v6 = ResourceManager.GetTowerModel(captureTowerName, v2, v, pathLockLevel)

				if towerModel:GetAttribute("UseBaseRigMethod") then
					towerModel = BaseRigMethodHandler.SetUp(towerModel, v6)
				end

				towerModel:PivotTo(pivot)
				towerModel.Parent = worldModel
				model:Destroy()

				if not flag4 then
					viewportScale = towerModel:GetAttribute("ViewportScale") or viewportScale
					viewportPosition = towerModel:GetAttribute("ViewportPosition") or viewportPosition
					viewportOrientation = towerModel:GetAttribute("ViewportOrientation") or viewportOrientation
				end

				model = towerModel
			end

			if (v4 or v5 or not flag4) and captureSkinName then
				local _
				model, _ = SkinHandler.ApplySkin(
					"Tower",
					captureTowerName,
					captureSkinName,
					model,
					v2 or overridePath,
					v or overrideLevel,
					pathLockLevel
				)
				model:PivotTo(pivot)
				model.Parent = worldModel
				viewportScale = model:GetAttribute("ViewportScale") or viewportScale
				viewportPosition = model:GetAttribute("ViewportPosition") or viewportPosition
				viewportOrientation = model:GetAttribute("ViewportOrientation") or viewportOrientation
			end

			for _, child in pairs(model:GetChildren()) do
				if child:GetAttribute("ViewportDestroy") then
					child:Destroy()
				end
			end

			if flag2 then
				for _, descendant in pairs(model:GetDescendants()) do
					if descendant:GetAttribute("TowerBarViewportDestroy") then
						descendant:Destroy()
					end
				end
			end

			local v6 = v2 and v2 ~= overridePath and 0 or overrideLevel
			local v7 = v2 == 1 and v or overridePath == 1 and v6 or 0
			local v8 = v2 == 2 and v or overridePath == 2 and v6 or 0
			local turretConfigs = TowerUtilities.GetLevelStats(towerConfig.UpgradePathData, v7, v8).TurretConfigs

			if model:GetAttribute("IgnoreTurretConfigs") then
				turretConfigs = nil
			end

			local turretConfigs2 = model:FindFirstChild("TurretConfigs")

			if turretConfigs2 then
				turretConfigs = require(turretConfigs2)
			end

			if turretConfigs then
				for _, turretConfig in pairs(turretConfigs) do
					local folder = model:FindFirstChild(turretConfig.ModelName)

					if folder then
						local primaryPart2 = model.PrimaryPart
						local autoWeldToInstanceName = turretConfig.AutoWeldToInstanceName

						if autoWeldToInstanceName then
							primaryPart2 = Utilities.TryGetInstanceFromPath(model, autoWeldToInstanceName)

							if not primaryPart2 then
								warn("TurretClass.New: AutoWeldToInstanceName not found", autoWeldToInstanceName)
							end
						end

						for _, part in pairs(folder:GetDescendants()) do
							if part:IsA("BasePart") then
								Utilities.Weld(primaryPart2, part)
							end
						end
					else
						warn("Didn't find " .. turretConfig.ModelName .. " in viewport character for", captureTowerName)
						print(model:GetFullName())
						print(v7, v8)
					end
				end
			end

			if flag then
				local primaryPart2 = model.PrimaryPart
				local v9 = not primaryPart2:GetAttribute("ViewportIgnoreCFrameOffset")
					and Utilities.TryReadChildValue(primaryPart2, "CFrameOffset")

				if v9 then
					if cframe then
						v9 *= cframe:Inverse()
					end

					model:PivotTo(pivot * v9)
				end

				if viewportOrientation then
					model:PivotTo(CFrame.new(model:GetPivot().Position) * CFrame.fromOrientation(
						math.rad(viewportOrientation.X),
						math.rad(viewportOrientation.Y),
						(math.rad(viewportOrientation.Z))
					))
				end

				if viewportPosition and viewportPosition ~= Vector3.new() then
					model:PivotTo(CFrame.new(viewportPosition) * model:GetPivot().Rotation)
				else
					local v10 = Utilities.TryReadChildValue(model, "HoverHeight", false)
						or model:GetAttribute("HoverHeight")
						or towerConfig.HoverHeight
						or 1.5 * model.PrimaryPart.Size.Y / model:GetScale()

					if v10 ~= v3 then
						model:PivotTo(model:GetPivot() + Vector3.new(0, v10 - v3, 0))
					end
				end

				if viewportScale and viewportScale == 0 then
					viewportScale = nil
				end

				model:ScaleTo(viewportScale or (value or 1) * scale)
			end
		end
	end

	local function CreateViewport()
		local v3 = captureSkinName and ResourceManager.GetTowerSkinCustomViewport(captureTowerName, captureSkinName)

		if v3 then
			v3:SetAttribute("IsSkinCustomViewport", true)
		end

		local v4 = v3 or ResourceManager.GetTowerViewport(captureTowerName)

		if not v4 then
			return v4
		end

		ProcessViewport(v4, v3 ~= nil)

		if not (RunService:IsStudio() and captureSkinName and captureSkinName ~= "" and (flag2 or flag and v)) then
			return v4
		end

		v4:SetAttribute("CaptureTowerName", captureTowerName)
		v4:SetAttribute("CaptureSkinName", captureSkinName)
		v4:SetAttribute("CaptureForTowerBar", flag2 == true)
		local v5

		if not flag2 then
			v5 = v2 or nil
		end

		v4:SetAttribute("CapturePath", v5)
		local v6

		if not flag2 then
			v6 = v or nil
		end

		v4:SetAttribute("CaptureLevel", v6)
		return v4
	end

	local function SetUpAnimations(instance)
		local worldModel = instance:FindFirstChildOfClass("WorldModel")

		if worldModel and flag3 ~= false then
			local function HandleAnimationModel(instance2)
				local animations = instance2:FindFirstChild("Animations")

				if animations then
					local child

					if childName then
						child = animations:FindFirstChild(childName)

						if
							childName == "VictoryDance"
							and instance2:GetAttribute("HideGunModelForVictoryDance")
							and towerConfig.GunModelName
						then
							local child2 = instance2:FindFirstChild(towerConfig.GunModelName)

							if child2 then
								child2:Destroy()
							end
						end
					end

					local v3 = child or animations:FindFirstChild("Idle")

					if v3 and v3.AnimationId == "" then
						Utilities.WarnEmptyAnimationOnce(instance2, v3)
					elseif v3 then
						local track = Instance.new("AnimationController", instance2):LoadAnimation(v3)
						track.Looped = true
						track:Play(0, nil, math.random(90, 110) / 100)
					end
				end
			end

			local model = worldModel:FindFirstChildOfClass("Model")
			local multipleInnerAnimations = model:GetAttribute("MultipleInnerAnimations")
			local innerAnimationsModelName = model:GetAttribute("InnerAnimationsModelName")
			local models = { model }

			if multipleInnerAnimations then
				models = not model:FindFirstChild("Animations") and {} or models

				for _, model2 in pairs(model:GetChildren()) do
					if model2:IsA("Model") and model2:FindFirstChild("Animations") then
						table.insert(models, model2)
					end
				end
			elseif innerAnimationsModelName then
				local child = model:FindFirstChild(innerAnimationsModelName)

				if child then
					models = { child }
				else
					warn("Couldn't find animation model with name " .. innerAnimationsModelName)
				end
			end

			for _, v3 in pairs(models) do
				HandleAnimationModel(v3)
			end
		end
	end

	local parent2 = captureSkinName
		and ResourceManager.IsTowerSkinPending(captureTowerName, captureSkinName)
		and ResourceManager.GetTowerViewport(captureTowerName)

	if parent2 then
		parent2:ClearAllChildren()
		parent2.Parent = parent
		local imageColor3 = parent2.ImageColor3
		local imageTransparency = parent2.ImageTransparency
		task.spawn(function()
			ResourceManager.RequestTowerSkinAsync(captureTowerName, captureSkinName)

			if not parent2.Parent then
				return
			end

			local viewport = CreateViewport()

			if not viewport then
				return
			end

			viewport.AnchorPoint = Vector2.zero
			viewport.Position = UDim2.fromScale(0, 0)
			viewport.Size = UDim2.fromScale(1, 1)
			viewport.ZIndex = parent2.ZIndex
			parent2.BackgroundTransparency = 1

			if parent2.ImageColor3 ~= imageColor3 then
				viewport.ImageColor3 = parent2.ImageColor3
			end

			if parent2.ImageTransparency ~= imageTransparency then
				viewport.ImageTransparency = parent2.ImageTransparency
			end

			for _, propertyName in ipairs({ "ImageColor3", "ImageTransparency", "ZIndex" }) do
				local v3 = propertyName
				parent2:GetPropertyChangedSignal(propertyName):Connect(function()
					viewport[v3] = parent2[v3]
				end)
			end

			for k, v3 in pairs(viewport:GetAttributes()) do
				parent2:SetAttribute(k, v3)
			end

			viewport.Parent = parent2
			SetUpAnimations(viewport)
		end)
		return parent2
	else
		local viewport = CreateViewport()

		if viewport then
			viewport.Parent = parent
			SetUpAnimations(viewport)
		end

		return viewport
	end
end

function TowerUtilities.GetMainAttackCount(p)
	local total = 0

	for _, v in pairs(p.TurretData) do
		if v.GunData.UseTowerLevelStats then
			total += v.GunCount
		end
	end

	return total
end

return TowerUtilities