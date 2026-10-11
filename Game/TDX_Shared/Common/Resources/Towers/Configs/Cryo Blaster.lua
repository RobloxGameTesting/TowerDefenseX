local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 225,
			Health = 50,
			DamageType = Enums.DamageTypes.Ice,
			IsSplash = true,
			SplashRadius = 1,
			SplashMaximumTargetsHit = 3,
			Damage = 0,
			ReloadTime = 0.2,
			Range = 7,
			StealthDetection = false,
			BodyHeatReduction = 0.5,
			PermanentSpeedMultiplierIfFrozen = 1,
			DamageMultiplierIfFrozen = 1,
			ThawTimeIfFrozen = _G.DEFAULT_THAW_TIME,
			IgnoreIceResistance = false,
			CanFreezeBoss = false,
			Description = "BASE",
			Icon = "rbxassetid://14229903033"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 225,
				HealthIncrease = 25,
				PermanentSpeedMultiplierIfFrozenIncrease = -0.25,
				Description = "Subzero Temperature",
				Icon = "rbxassetid://14229902905",
				UpgradeIcon = "rbxassetid://15282235862"
			},
			{
				Cost = 250,
				HealthIncrease = 35,
				RangeIncrease = 2.5,
				Description = "Bigger Fan",
				Icon = "rbxassetid://14229902781",
				UpgradeIcon = "rbxassetid://15282236548"
			},
			{
				Cost = 1000,
				HealthIncrease = 75,
				SplashMaximumTargetsHitIncrease = 2,
				SplashRadiusIncrease = 0,
				DamageIncrease = 0.5,
				BodyHeatReductionIncrease = 2,
				Description = "Cryo Thrower",
				Icon = "rbxassetid://14229902473",
				UpgradeIcon = "rbxassetid://15282236221"
			},
			{
				Cost = 2750,
				HealthIncrease = 250,
				SplashMaximumTargetsHitIncrease = 2,
				SplashRadiusIncrease = 1,
				BodyHeatReductionIncrease = 2,
				DamageMultiplierIfFrozenIncrease = 0.4,
				Description = "Bigger Tank",
				Icon = "rbxassetid://14229902030",
				UpgradeIcon = "rbxassetid://15282236427"
			},
			{
				Cost = 7500,
				HealthIncrease = 550,
				SplashMaximumTargetsHitIncrease = 5,
				DamageIncrease = 2,
				BodyHeatReductionIncrease = 7,
				DamageMultiplierIfFrozenIncrease = 0.55,
				SplashRadiusIncrease = 0.5,
				IgnoreIceResistance = true,
				Description = "Snow Storm",
				Icon = "rbxassetid://14229901705",
				UpgradeIcon = "rbxassetid://15282235913"
			}
		},
		Path2Data = {
			{
				Cost = 450,
				HealthIncrease = 15,
				DamageIncrease = 0.5,
				BodyHeatReductionIncrease = 1.5,
				DamageMultiplierIfFrozenIncrease = 0.25,
				Description = "Ice Block",
				Icon = "rbxassetid://14229902905",
				UpgradeIcon = "rbxassetid://15282236097"
			},
			{
				Cost = 475,
				HealthIncrease = 35,
				SplashMaximumTargetsHitIncrease = 2,
				RangeIncrease = 3,
				Description = "Turbo Turbine",
				Icon = "rbxassetid://14229902781",
				UpgradeIcon = "rbxassetid://15282235778"
			},
			{
				Cost = 2100,
				HealthIncrease = 150,
				ProjectileName = Enums.Projectiles.IceShard,
				RemoveSplash = true,
				DamageIncrease = 19.5,
				ReloadTimeDecrease = -1.8,
				DamageMultiplierIfFrozenIncrease = 0.05,
				ThawTimeIfFrozenIncrease = 1,
				RangeIncrease = 4.5,
				OverrideBodyHeatReduction = 40,
				Description = "Cryo Rifle",
				Icon = "rbxassetid://14229902609",
				UpgradeIcon = "rbxassetid://15282236309"
			},
			{
				Cost = 5675,
				HealthIncrease = 475,
				ProjectileName = Enums.Projectiles.IceShard,
				DamageIncrease = 30,
				ReloadTimeDecrease = 0.25,
				RangeIncrease = 2,
				OverrideBodyHeatReduction = 85,
				Description = "Overcharged Tanks",
				Icon = "rbxassetid://14229902235",
				UpgradeIcon = "rbxassetid://15282236008"
			},
			{
				Cost = 14000,
				HealthIncrease = 1250,
				ProjectileName = Enums.Projectiles.IceShardLarge,
				DamageIncrease = 50,
				ReloadTimeDecrease = 0.5,
				DamageMultiplierIfFrozenIncrease = 0.25,
				RangeIncrease = 1,
				OverrideBodyHeatReduction = 215,
				GainStealthDetection = true,
				GainCanTargetAir = true,
				ThawTimeIfFrozenIncrease = 2,
				CanFreezeBoss = true,
				Description = "Deep Freeze",
				Icon = "rbxassetid://14229901869",
				UpgradeIcon = "rbxassetid://15282236163"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoRestartAttackAnimationIfPlaying = true,
	CanPlayAttackAnimationAgain = true,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.1,
	RotationOffset = CFrame.Angles(0, -3.141592653589793, 0),
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
		}
	}
}