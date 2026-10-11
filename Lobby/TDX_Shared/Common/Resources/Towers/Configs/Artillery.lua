local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ManualAiming = true,
	DisplayReloadTime = true,
	UpgradePathData = {
		BaseLevelData = {
			Cost = 1850,
			Health = 400,
			DamageType = Enums.DamageTypes.Explosive,
			ProjectileName = Enums.Projectiles.ArtilleryProjectile,
			IsSplash = true,
			SplashRadius = 4,
			SplashAlwaysHitAirAndGround = true,
			Damage = 65,
			ReloadTime = 11,
			Range = 65,
			StealthDetection = false,
			BurstSize = 1,
			BurstInterval = 0.3333,
			Description = "Base",
			Icon = "rbxassetid://14868381107"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 550,
				HealthIncrease = 30,
				DamageIncrease = 0,
				ReloadTimeDecrease = 2,
				RangeIncrease = 0,
				Description = "Crew Training",
				Icon = "rbxassetid://14868380868",
				UpgradeIcon = "rbxassetid://15247545585"
			},
			{
				Cost = 1000,
				HealthIncrease = 175,
				DamageIncrease = 0,
				ReloadTimeDecrease = 1,
				RangeIncrease = 10,
				SplashRadiusIncrease = 1,
				Description = "M119+",
				Icon = "rbxassetid://14868380643",
				UpgradeIcon = "rbxassetid://15247545166"
			},
			{
				Cost = 2000,
				HealthIncrease = 80,
				DamageIncrease = 0,
				ReloadTimeDecrease = 2,
				RangeIncrease = 0,
				Description = "Fire Artillery",
				Icon = "rbxassetid://14868380282",
				UpgradeIcon = "rbxassetid://15247545472"
			},
			{
				Cost = 6500,
				HealthIncrease = 50,
				DamageIncrease = 100,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Bigger Shells",
				Icon = "rbxassetid://14868395530",
				UpgradeIcon = "rbxassetid://15247545703"
			},
			{
				Cost = 18500,
				HealthIncrease = 1000,
				DamageIncrease = 25,
				ReloadTimeDecrease = -0.5,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0,
				BurstSizeIncrease = 2,
				DisableManualAiming = true,
				Description = "Triple Barrel",
				Icon = "rbxassetid://14868379508",
				UpgradeIcon = "rbxassetid://15247544813"
			}
		},
		Path2Data = {
			{
				Cost = 1200,
				HealthIncrease = 25,
				DamageIncrease = 25,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				SplashRadiusIncrease = 1,
				Description = "HE Shells",
				Icon = "rbxassetid://14868380868",
				UpgradeIcon = "rbxassetid://15247545359"
			},
			{
				Cost = 3000,
				HealthIncrease = 35,
				DamageIncrease = 60,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Heavy Shells",
				Icon = "rbxassetid://14868380643",
				UpgradeIcon = "rbxassetid://15247545254"
			},
			{
				Cost = 10250,
				HealthIncrease = 1000,
				ProjectileName = Enums.Projectiles.ArtilleryProjectileLarge,
				DamageIncrease = 125,
				ReloadTimeDecrease = 0,
				RangeIncrease = 30,
				SplashRadiusIncrease = 4,
				Description = "M198 Howitzer",
				Icon = "rbxassetid://14868380444",
				UpgradeIcon = "rbxassetid://15247545043"
			},
			{
				Cost = 12000,
				HealthIncrease = 100,
				ProjectileName = Enums.Projectiles.ArtilleryProjectileLarge,
				DamageIncrease = 260,
				ReloadTimeDecrease = 0,
				RangeIncrease = 30,
				Description = "Bigger Barrel",
				Icon = "rbxassetid://14868380128",
				UpgradeIcon = "rbxassetid://15247545849"
			},
			{
				Cost = 100000,
				HealthIncrease = 7000,
				ProjectileName = Enums.Projectiles.ArtilleryProjectileExtraLarge,
				DamageIncrease = 2400,
				GainStealthDetection = true,
				ReloadTimeDecrease = -2,
				RangeIncrease = 70,
				SplashRadiusIncrease = 4,
				DisableManualAiming = true,
				GainStunImmunity = true,
				Description = "Skyhawk Artillery",
				Icon = "rbxassetid://14868379685",
				UpgradeIcon = "rbxassetid://15247544921"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoRestartAttackAnimationIfPlaying = true,
	GunModelName = "FiringVFX",
	GunModelEffectsDelay = 0.25,
	MaxObstacleHeight = 10,
	HasCustomCode = true,
	Radius = 2.5,
	HoverHeight = 0.842,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	BuffEffectScale = 2,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 250,
			CostIncreasePerLevel = 475,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 75,
			CostIncreasePerLevel = 50,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Firerate,
			Cost = 400,
			CostIncreasePerLevel = 375,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 300,
			CostIncreasePerLevel = 300,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 25,
			CostIncreasePerLevel = 10,
			Amount = 0.05
		}
	}
}