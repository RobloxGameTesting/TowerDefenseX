local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 8, 4, 3, 2 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 1450,
			Health = 400,
			CanRebuild = true,
			RebuildTime = 15,
			RebuildTimeIncreaseEachDeath = 0,
			CanTargetAir = true,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 4,
			ReloadTime = 0.2,
			Range = 14,
			StealthDetection = false,
			IgnoreObstacles = true,
			AviatorMovementConfig = {
				Speed = 7,
				Radius = 16,
				Altitude = 18,
				PortAngle = 15,
				TakeoffTime = 3
			},
			AbilityNames = { Enums.TowerAbilities.AviatorFlightMode },
			Description = "BASE",
			Icon = ""
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 550,
				HealthIncrease = 100,
				DamageIncrease = 4,
				RangeIncrease = 2,
				AbilityNames = { Enums.TowerAbilities.AviatorFlightMode },
				Description = "Heavy Ammo",
				Icon = "",
				UpgradeIcon = "rbxassetid://15266660711"
			},
			{
				Cost = 6950,
				HealthIncrease = 200,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0.03,
				AbilityNames = { Enums.TowerAbilities.AviatorFlightMode, Enums.TowerAbilities.AviatorBombL2 },
				Description = "Bombs",
				Icon = "",
				UpgradeIcon = "rbxassetid://81852015947959"
			},
			{
				Cost = 19650,
				HealthIncrease = 725,
				DamageIncrease = 20,
				RangeIncrease = 2,
				PierceCountIncrease = 1,
				ReloadTimeDecrease = 0.02,
				GainStealthDetection = true,
				AbilityNames = { Enums.TowerAbilities.AviatorFlightMode, Enums.TowerAbilities.AviatorBombL3 },
				Description = "WW2 Fighter",
				Icon = "",
				UpgradeIcon = "rbxassetid://103023423696350"
			},
			{
				Cost = 47000,
				HealthIncrease = 1800,
				DamageIncrease = 40,
				ReloadTimeDecrease = 0.02,
				GainIgnoreResistance = true,
				AbilityNames = { Enums.TowerAbilities.AviatorFlightMode, Enums.TowerAbilities.AviatorBombL4 },
				Description = "Pilot Training",
				Icon = "",
				UpgradeIcon = "rbxassetid://132449651955939"
			},
			{
				Cost = 130000,
				HealthIncrease = 4000,
				DamageIncrease = 75,
				RangeIncrease = 5,
				ReloadTimeDecrease = 0.04,
				AbilityNames = {
					Enums.TowerAbilities.AviatorFlightMode,
					Enums.TowerAbilities.AviatorBombL5,
					Enums.TowerAbilities.AviatorMissilesL5
				},
				Description = "Space Fighter",
				Icon = "",
				UpgradeIcon = "rbxassetid://98361804521971"
			}
		}
	},
	HelicopterCrashData = {
		RandomRadius = 12,
		SplashRadius = 6,
		Duration = 1.7,
		DurationVariance = 0.3,
		DamageData = {
			LowerBoundBase = 200,
			LowerBoundMultiplier = 50,
			UpperBoundBase = 300,
			UpperBoundMultiplier = 200
		},
		ExplosionEffectName = Enums.VisualEffects.DroneDeath
	},
	IsMechanical = true,
	PlacementType = Enums.PlacementTypes.Ground,
	ForceIsAirUnit = true,
	IgnoreAirPlacementLimit = true,
	EMPVulnerable = true,
	AnimationTimeScale = 1,
	GunModelName = "Weapon",
	HasCustomCode = true,
	Radius = 2.5,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BuffEffectScale = 2,
	UseMovingRangeCircle = true,
	NoBuffs = true,
	NoHeal = true,
	NoStealthShimmer = true,
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 100,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 500,
			CostIncreasePerLevel = 350,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 125,
			CostIncreasePerLevel = 75,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 50,
			CostIncreasePerLevel = 20,
			Amount = 0.05
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://91895906265228"
}