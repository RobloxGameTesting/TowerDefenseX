local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 300,
			Health = 125,
			DamageType = Enums.DamageTypes.Melee,
			IsSplash = true,
			SplashRadius = 1.5,
			SplashMaximumTargetsHit = 4,
			Damage = 10,
			DamageDelay = 0.22,
			ReloadTime = 2.75,
			Range = 4.5,
			StealthDetection = false,
			Description = "TODO",
			Icon = "rbxassetid://17654751392"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 225,
				HealthIncrease = 25,
				DamageIncrease = 5,
				Description = "Heavy Weight",
				Icon = "rbxassetid://17654751216",
				UpgradeIcon = "rbxassetid://17684278215"
			},
			{
				Cost = 375,
				HealthIncrease = 35,
				DamageIncrease = 12,
				Description = "Strength Training",
				Icon = "rbxassetid://17654751062",
				UpgradeIcon = "rbxassetid://17684277059"
			},
			{
				Cost = 2100,
				HealthIncrease = 300,
				DamageIncrease = 65,
				ReloadTimeDecrease = 0,
				SplashMaximumTargetsHitIncrease = 2,
				StunType = Enums.StunTypes.SlammerSlam,
				StunDurationIncrease = 0.75,
				GainStunImmunity = true,
				Description = "Slam Attack",
				Icon = "rbxassetid://17654750907",
				UpgradeIcon = "rbxassetid://17684277410"
			},
			{
				Cost = 5750,
				HealthIncrease = 650,
				DamageIncrease = 80,
				SplashMaximumTargetsHitIncrease = 4,
				SplashRadiusIncrease = 1,
				StunDurationIncrease = 0.2,
				Description = "Splash Damage",
				Icon = "rbxassetid://17654750698",
				UpgradeIcon = "rbxassetid://17684277264"
			},
			{
				Cost = 26000,
				HealthIncrease = 1750,
				ReloadTimeDecrease = 0.5,
				DamageIncrease = 275,
				RangeIncrease = 1,
				SplashMaximumTargetsHitIncrease = 4,
				StunDurationIncrease = 0.5,
				AbilityNames = { Enums.TowerAbilities.GrandSlam },
				Description = "Grand Slam",
				Icon = "rbxassetid://17654750417",
				UpgradeIcon = "rbxassetid://17684278474"
			}
		},
		Path2Data = {
			{
				Cost = 250,
				HealthIncrease = 15,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 0.5,
				Description = "Better Handling",
				Icon = "rbxassetid://17654751216",
				UpgradeIcon = "rbxassetid://17684278722"
			},
			{
				Cost = 450,
				HealthIncrease = 35,
				DamageIncrease = 4,
				RangeIncrease = 0.5,
				ReloadTimeDecrease = 0.2,
				Description = "Advanced Training",
				Icon = "rbxassetid://17654751062",
				UpgradeIcon = "rbxassetid://17684278925"
			},
			{
				Cost = 1800,
				HealthIncrease = 400,
				DamageIncrease = 20,
				StunType = Enums.StunTypes.SlammerShock,
				StunDurationIncrease = 0.5,
				ReloadTimeDecrease = 0.2,
				GainStealthDetection = true,
				Description = "Shock Hammer",
				Icon = "rbxassetid://17654752086",
				UpgradeIcon = "rbxassetid://17684277522"
			},
			{
				Cost = 3125,
				HealthIncrease = 700,
				DamageIncrease = 30,
				StunDurationIncrease = 0.5,
				ReloadTimeDecrease = 0.2,
				GainStunImmunity = true,
				Description = "Increased Batteries",
				Icon = "rbxassetid://17654751972",
				UpgradeIcon = "rbxassetid://17684278044"
			},
			{
				Cost = 12000,
				HealthIncrease = 1100,
				DamageIncrease = 175,
				StunDurationIncrease = 0.7,
				ReloadTimeDecrease = 0.2,
				Description = "Maximum Charge",
				Icon = "rbxassetid://17654751857",
				UpgradeIcon = "rbxassetid://17684277762"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Weapon",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, 0, 0),
	SetUpKeyframeReachedEventForAttack = true,
	DisallowedBuffTypesMap = {
		[Enums.TowerBuffTypes.Range] = true,
		[Enums.TowerBuffTypes.Range2] = true,
		[Enums.TowerBuffTypes.Range3] = true
	},
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 185,
			CostIncreasePerLevel = 110,
			Amount = 0.35
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 325,
			CostIncreasePerLevel = 150,
			Amount = 0.6
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 325,
			CostIncreasePerLevel = 150,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Firerate,
			Cost = 175,
			CostIncreasePerLevel = 100,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 350,
			CostIncreasePerLevel = 125,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.StunDuration,
			Cost = 275,
			CostIncreasePerLevel = 400,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 50,
			CostIncreasePerLevel = 15,
			Amount = 0.1
		}
	}
}