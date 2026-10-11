local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 8, 7, 6, 5 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 300,
			Health = 500,
			DamageType = Enums.DamageTypes.Toxic,
			SplashMaximumTargetsHit = 1,
			Damage = 2,
			ReloadTime = 1.5,
			Range = 12,
			SlowdownPercentage = 0.1,
			SlowdownDuration = 3,
			StealthDetection = false,
			Description = "",
			Icon = "rbxassetid://117043807845392"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 400,
				HealthIncrease = 150,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				SlowdownPercentageIncrease = 0.05,
				SlowdownDurationIncrease = 0,
				Description = "Sticky Goo",
				Icon = "rbxassetid://107153277042502",
				UpgradeIcon = "rbxassetid://103012457550519"
			},
			{
				Cost = 1000,
				HealthIncrease = 200,
				DamageIncrease = 5,
				ReloadTimeDecrease = 0.15,
				RangeIncrease = 0,
				SlowdownPercentageIncrease = 0.05,
				SlowdownDurationIncrease = 2,
				Description = "Slow Dry",
				Icon = "rbxassetid://128176785347701",
				UpgradeIcon = "rbxassetid://97173429655092"
			},
			{
				Cost = 1850,
				HealthIncrease = 250,
				DamageIncrease = -5,
				OverrideReloadTime = 0.2,
				RangeIncrease = -3,
				SlowdownDurationIncrease = 0,
				SplashRadiusIncrease = 1,
				SplashMaximumTargetsHitOverride = 3,
				Description = "Glue Hose",
				Icon = "rbxassetid://105108605718197",
				UpgradeIcon = "rbxassetid://110979570078454"
			},
			{
				Cost = 3000,
				HealthIncrease = 400,
				DamageIncrease = 5,
				OverrideReloadTime = 0.2,
				GainStunImmunity = true,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0.5,
				SplashMaximumTargetsHitOverride = 5,
				Description = "Acidic Goo",
				Icon = "rbxassetid://129869709854363",
				UpgradeIcon = "rbxassetid://105897614359505"
			},
			{
				Cost = 6000,
				HealthIncrease = 600,
				DamageIncrease = 4,
				OverrideReloadTime = 0.2,
				RangeIncrease = 0,
				SlowdownPercentageIncrease = 0.1,
				SlowdownDurationIncrease = 3,
				SplashRadiusIncrease = 0.5,
				SplashMaximumTargetsHitOverride = 7,
				AbilityNames = { Enums.TowerAbilities.GooGunnerSplat },
				Description = "Goo Units",
				Icon = "rbxassetid://77017451552763",
				UpgradeIcon = "rbxassetid://80148863196129"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.308,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 75,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 150,
			CostIncreasePerLevel = 100,
			Amount = 1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 100,
			CostIncreasePerLevel = 50,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 125,
			CostIncreasePerLevel = 50,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 150,
			CostIncreasePerLevel = 75,
			Amount = 0.1
		}
	}
}