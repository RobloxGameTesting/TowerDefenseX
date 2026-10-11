local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Gun",
	RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 10, MinRotationX = -55 }
}
local v2 = {
	ModelName = "Turret",
	AutoWeldToInstanceName = "MainBody",
	RotationConstraintConfig = {},
	TurretGunConfigs = { v }
}
return {
	LimitMap = { 3, 3, 2, 2 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 2125,
			Health = 850,
			CanTargetAir = false,
			DamageType = Enums.DamageTypes.Ice,
			IsSplash = true,
			SplashRadius = 1,
			SplashMaximumTargetsHit = 2,
			Damage = 1,
			ReloadTime = 0.2,
			Range = 11,
			StealthDetection = false,
			BodyHeatReduction = 1.5,
			PermanentSpeedMultiplierIfFrozen = 1,
			DamageMultiplierIfFrozen = 1,
			ThawTimeIfFrozen = _G.DEFAULT_THAW_TIME,
			IgnoreIceResistance = false,
			StunImmunity = true,
			MovementSpeed = 9,
			IgnoreObstacles = true,
			AbilityNames = {
				Enums.TowerAbilities.HelicopterMoveToLocation,
				Enums.TowerAbilities.HelicopterMoveToPlayer
			},
			TurretConfigs = { v2 },
			Description = "BASE",
			Icon = "rbxassetid://84468241972438"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 2500,
				GainStealthDetection = true,
				HealthIncrease = 100,
				DamageIncrease = 1,
				GainCanTargetAir = true,
				BodyHeatReductionIncrease = 2,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer
				},
				TurretConfigs = { v2 },
				Description = "Bigger Beam",
				Icon = "rbxassetid://77912003261370",
				UpgradeIcon = "rbxassetid://123943479104530"
			},
			{
				Cost = 7500,
				HealthIncrease = 100,
				DamageIncrease = 2,
				BodyHeatReductionIncrease = 7.5,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer
				},
				TurretConfigs = { v2 },
				Description = "Speed Reduction",
				Icon = "rbxassetid://116518096658631",
				UpgradeIcon = "rbxassetid://93994274783639"
			},
			{
				Cost = 17250,
				HealthIncrease = 600,
				DamageIncrease = 3,
				RangeIncrease = 12,
				BodyHeatReductionIncrease = 20,
				MovementSpeedIncrease = 0,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.CryoHelicopterMissilesL3
				},
				TurretConfigs = { v2 },
				Description = "Ice Missiles",
				Icon = "rbxassetid://87143775631248",
				UpgradeIcon = "rbxassetid://115683376392553"
			},
			{
				Cost = 46800,
				HealthIncrease = 2000,
				DamageIncrease = 5,
				RangeIncrease = 0,
				SplashMaximumTargetsHitIncrease = 1,
				BodyHeatReductionIncrease = 56,
				MovementSpeedIncrease = 3,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.CryoHelicopterMissilesL4
				},
				TurretConfigs = { v2 },
				Description = "Cryo Munitions",
				Icon = "rbxassetid://71924226240604",
				UpgradeIcon = "rbxassetid://129309073030407"
			},
			{
				Cost = 175000,
				IgnoreIceResistance = true,
				HealthIncrease = 3250,
				DamageIncrease = 7,
				BodyHeatReductionIncrease = 344,
				SplashRadiusIncrease = 0.5,
				CanFreezeBoss = true,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.CryoHelicopterMissilesL5
				},
				TurretConfigs = {
					v2,
					{
						ModelName = "TurretLeft",
						AutoWeldToInstanceName = "MainBody",
						RotationConstraintConfig = {},
						TurretGunConfigs = { v }
					},
					{
						ModelName = "TurretRight",
						AutoWeldToInstanceName = "MainBody",
						RotationConstraintConfig = {},
						TurretGunConfigs = { v }
					}
				},
				Description = "Mi-Ice Hind",
				Icon = "rbxassetid://81664444846997",
				UpgradeIcon = "rbxassetid://123236934881264"
			}
		}
	},
	HelicopterMovement = true,
	HelicopterCrashData = {
		RandomRadius = 12,
		SplashRadius = 6,
		Duration = 2.5,
		DurationVariance = 0.5,
		DamageData = {
			LowerBoundBase = 150,
			LowerBoundMultiplier = 40,
			UpperBoundBase = 250,
			UpperBoundMultiplier = 180
		},
		BodyHeatReductionData = {
			LowerBoundBase = 1000,
			LowerBoundMultiplier = 2000,
			UpperBoundBase = 2000,
			UpperBoundMultiplier = 3000
		},
		TowerBuffNames = { Enums.TowerBuffs.CryoHelicopterCrashFreeze },
		ExplosionEffectName = Enums.VisualEffects.CryoHeliDeathBlast
	},
	IsMechanical = true,
	PlacementType = Enums.PlacementTypes.Air,
	EMPVulnerable = true,
	AnimationTimeScale = 1,
	GunModelName = "Weapons",
	HasCustomCode = true,
	Radius = 0.5,
	HoverHeight = _G.AIR_TOWER_HOVER_HEIGHT,
	HoverHeightVariance = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	BuffEffectScale = 2,
	UseMovingRangeCircle = true,
	NoBuffs = true,
	NoHeal = true,
	AimAllTurretsForAttack = true,
	BeamEffectForDefaultAttack = true,
	DefaultBeamEffectHandlingData = {
		{
			BeamParentInstanceName = "Turret>Gun>Barrel",
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		},
		{
			IgnoreIfNotFound = true,
			BeamParentInstanceName = "TurretLeft>Gun>Barrel",
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		},
		{
			IgnoreIfNotFound = true,
			BeamParentInstanceName = "TurretRight>Gun>Barrel",
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		}
	},
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Freeze,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.MovementSpeed,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.06
		}
	}
}