local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.HelicopterSmallBlast,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 0.35,
	VarianceY = 0.25
}
local rotatingBarrelData = {
	{
		WeldPointerName = "BarrelPointerL",
		TimeToMaxRotationSpeed = 0.25,
		TimeToSpinAfterShot = 0.7,
		TimeToStopRotation = 1.3,
		MaxRotationSpeedX = 20
	},
	{
		WeldPointerName = "BarrelPointerR",
		TimeToMaxRotationSpeed = 0.25,
		TimeToSpinAfterShot = 0.7,
		TimeToStopRotation = 1.3,
		MaxRotationSpeedX = 20
	}
}
local v = {
	ModelName = "Turret",
	AutoWeldToInstanceName = "MainBody",
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 10, MinRotationX = -25 }
		}
	}
}
local v2 = {
	ModelName = "Turret",
	AutoWeldToInstanceName = "MainBody",
	RotationConstraintConfig = { CanRotateY = true, MinRotationX = -90, MaxRotationX = 90 },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 10, MinRotationX = -75 },
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedX = 20
				}
			}
		}
	}
}
local baseLevelData = {
	Cost = 20000,
	Health = 1800,
	CanTargetAir = true,
	DamageType = Enums.DamageTypes.Bullet,
	Damage = 15,
	ReloadTime = 0.1,
	Range = 13,
	StealthDetection = false,
	MovementSpeed = 9,
	IgnoreObstacles = true,
	AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation, Enums.TowerAbilities.HelicopterMoveToPlayer },
	RotatingBarrelData = rotatingBarrelData,
	Description = "BASE",
	Icon = "rbxassetid://115988312030723"
}
local path1Data = {
	{
		Cost = 25000,
		HealthIncrease = 250,
		DamageIncrease = 10,
		ReloadTimeDecrease = 0.02,
		AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation, Enums.TowerAbilities.HelicopterMoveToPlayer },
		RotatingBarrelData = rotatingBarrelData,
		Description = "Minigun Upgrade",
		Icon = "rbxassetid://125032844297384",
		UpgradeIcon = "rbxassetid://118804053758009"
	},
	{
		Cost = 31000,
		HealthIncrease = 300,
		DamageIncrease = 10,
		ReloadTimeDecrease = 0.02,
		AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation, Enums.TowerAbilities.HelicopterMoveToPlayer },
		RotatingBarrelData = rotatingBarrelData,
		Description = "Barrel Spinning",
		Icon = "rbxassetid://79213280605935",
		UpgradeIcon = "rbxassetid://76276874446072"
	},
	{
		Cost = 60000,
		HealthIncrease = 1200,
		DamageIncrease = 12,
		GainStealthDetection = true,
		ReloadTimeDecrease = 0,
		RangeIncrease = 12,
		MovementSpeedIncrease = 0,
		AbilityNames = {
			Enums.TowerAbilities.HelicopterMoveToLocation,
			Enums.TowerAbilities.HelicopterMoveToPlayer,
			Enums.TowerAbilities.HelicopterMoveToFirst,
			Enums.TowerAbilities.HelicopterMissilesP1L3
		},
		RotatingBarrelData = rotatingBarrelData,
		Description = "Huey",
		Icon = "rbxassetid://88330369600335",
		UpgradeIcon = "rbxassetid://133123946770272"
	},
	{
		Cost = 120000,
		HealthIncrease = 5000,
		DamageIncrease = 42,
		ReloadTimeDecrease = -0.03,
		RangeIncrease = 0,
		SplashRadiusIncrease = 0.5,
		DamageType = Enums.DamageTypes.Explosive,
		MovementSpeedIncrease = 3,
		AbilityNames = {
			Enums.TowerAbilities.HelicopterMoveToLocation,
			Enums.TowerAbilities.HelicopterMoveToPlayer,
			Enums.TowerAbilities.HelicopterMoveToFirst,
			Enums.TowerAbilities.HelicopterMissilesP1L4,
			Enums.TowerAbilities.HelicopterRocketsP1L4
		},
		ClientHitEffectData = clientHitEffectData,
		TurretConfigs = { v },
		Description = "Apache",
		Icon = "rbxassetid://139386003674375",
		UpgradeIcon = "rbxassetid://128783464795921"
	},
	{
		Cost = 320000,
		HealthIncrease = 10000,
		DamageIncrease = 100,
		ReloadTimeDecrease = 0,
		RangeIncrease = 0,
		SplashRadiusIncrease = 0.5,
		AbilityNames = {
			Enums.TowerAbilities.HelicopterMoveToLocation,
			Enums.TowerAbilities.HelicopterMoveToPlayer,
			Enums.TowerAbilities.HelicopterMoveToFirst,
			Enums.TowerAbilities.HelicopterMissilesP1L5,
			Enums.TowerAbilities.HelicopterRocketsP1L5,
			Enums.TowerAbilities.HelicopterAntiAirMissilesP1L5
		},
		ClientHitEffectData = clientHitEffectData,
		TurretConfigs = { v },
		Description = "War Apache",
		Icon = "rbxassetid://132335336161741",
		UpgradeIcon = "rbxassetid://84874793261030"
	}
}
local path2Data = {
	{
		Cost = 9500,
		HealthIncrease = 100,
		DamageIncrease = 6,
		ReloadTimeDecrease = 0,
		RangeIncrease = 0,
		AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation, Enums.TowerAbilities.HelicopterMoveToPlayer },
		RotatingBarrelData = rotatingBarrelData,
		Description = "Heavy Ammo",
		Icon = "rbxassetid://125032844297384",
		UpgradeIcon = "rbxassetid://15266660711"
	},
	{
		Cost = 13500,
		HealthIncrease = 150,
		DamageIncrease = 11,
		ReloadTimeDecrease = 0,
		RangeIncrease = 5,
		MovementSpeedIncrease = 3,
		GainStunImmunity = true,
		AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation, Enums.TowerAbilities.HelicopterMoveToPlayer },
		RotatingBarrelData = rotatingBarrelData,
		Description = "Advanced Training",
		Icon = "rbxassetid://79213280605935",
		UpgradeIcon = "rbxassetid://77076791313048"
	},
	{
		Cost = 50000,
		HealthIncrease = 1800,
		DamageIncrease = 5,
		ReloadTimeDecrease = 0,
		RangeIncrease = 0,
		PierceCountIncrease = 1,
		GainStealthDetection = true,
		MovementSpeedIncrease = 6,
		AbilityNames = {
			Enums.TowerAbilities.HelicopterMoveToLocation,
			Enums.TowerAbilities.HelicopterMoveToPlayer,
			Enums.TowerAbilities.HelicopterMissilesP2L3,
			Enums.TowerAbilities.HelicopterRocketsP2L3
		},
		TurretConfigs = { v2 },
		Description = "AH-1Z Viper",
		Icon = "rbxassetid://78121553302531",
		UpgradeIcon = "rbxassetid://113885103249216"
	},
	{
		Cost = 75000,
		HealthIncrease = 250,
		DamageIncrease = 30,
		ReloadTimeDecrease = 0,
		RangeIncrease = 0,
		AbilityNames = {
			Enums.TowerAbilities.HelicopterMoveToLocation,
			Enums.TowerAbilities.HelicopterMoveToPlayer,
			Enums.TowerAbilities.HelicopterMissilesP2L4,
			Enums.TowerAbilities.HelicopterRocketsP2L4
		},
		TurretConfigs = { v2 },
		Description = "Upgraded Armaments",
		Icon = "rbxassetid://81689357082048",
		UpgradeIcon = "rbxassetid://84093140264347"
	},
	{
		Cost = 150000,
		HealthIncrease = 3000,
		DamageIncrease = 72,
		ReloadTimeDecrease = 0,
		RangeIncrease = 8,
		MovementSpeedIncrease = 25,
		GainStealth = true,
		RegainStealthIfRevealed = true,
		TimeToRegainStealthOverride = 3,
		AbilityNames = {
			Enums.TowerAbilities.HelicopterMoveToLocation,
			Enums.TowerAbilities.HelicopterMoveToPlayer,
			Enums.TowerAbilities.HelicopterMissilesP2L5,
			Enums.TowerAbilities.HelicopterStealthReveal
		},
		TurretConfigs = {
			{
				ModelName = "Turret",
				AutoWeldToInstanceName = "MainBody",
				RotationConstraintConfig = {},
				TurretGunConfigs = {
					{
						ModelName = "Gun",
						RotationConstraintConfig = {
							CanRotateX = true,
							MaxRotationX = 10,
							MinRotationX = -45
						},
						RotatingBarrelData = {
							{
								WeldPointerName = "RotatingBarrelWeld",
								TimeToMaxRotationSpeed = 0.25,
								TimeToSpinAfterShot = 0.7,
								TimeToStopRotation = 1.3,
								MaxRotationSpeedZ = 20
							}
						}
					}
				}
			}
		},
		Description = "Stealth Comanche",
		Icon = "rbxassetid://80661752126223",
		UpgradeIcon = "rbxassetid://76165538319322"
	}
}
return {
	LimitMap = { 4, 2, 1, 1 },
	DifficultyToLimitMapOverride = {
		[Enums.Difficulties.PVP_1V1] = { 2, 2, 2, 2 }
	},
	UpgradePathData = {
		BaseLevelData = baseLevelData,
		PathLockLevel = 3,
		Path1Data = path1Data,
		Path2Data = path2Data
	},
	HelicopterMovement = true,
	HelicopterCrashData = {
		RandomRadius = 12,
		SplashRadius = 6,
		Duration = 2.5,
		DurationVariance = 0.5,
		DamageData = {
			LowerBoundBase = 200,
			LowerBoundMultiplier = 50,
			UpperBoundBase = 300,
			UpperBoundMultiplier = 200
		},
		ExplosionEffectName = Enums.VisualEffects.ApexPredatorMissileHit
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
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 150,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 400,
			CostIncreasePerLevel = 600,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 500,
			CostIncreasePerLevel = 300,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.MovementSpeed,
			Cost = 75,
			CostIncreasePerLevel = 25,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 20,
			CostIncreasePerLevel = 10,
			Amount = 0.1
		}
	}
}