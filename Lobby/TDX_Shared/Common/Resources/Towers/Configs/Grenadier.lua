local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 450,
			Health = 120,
			DamageType = Enums.DamageTypes.Explosive,
			ProjectileName = Enums.Projectiles.GrenadierGrenadeBase,
			IsSplash = true,
			SplashRadius = 2.5,
			Damage = 8,
			ReloadTime = 3,
			Range = 9.5,
			StealthDetection = false,
			Description = "Base",
			Icon = "rbxassetid://15978643482"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 140,
				HealthIncrease = 25,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 1,
				Description = "Advanced Training",
				Icon = "rbxassetid://15978643296",
				UpgradeIcon = "rbxassetid://15988972217"
			},
			{
				Cost = 400,
				HealthIncrease = 40,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0.5,
				SplashRadiusIncrease = 0.5,
				Description = "Grenade Knowledge",
				Icon = "rbxassetid://15978643132",
				UpgradeIcon = "rbxassetid://15988971606"
			},
			{
				Cost = 1350,
				HealthIncrease = 150,
				DamageIncrease = 10,
				RangeIncrease = 2,
				GainStealthDetection = true,
				Description = "Sensor Grenades",
				Icon = "rbxassetid://15978642842",
				UpgradeIcon = "rbxassetid://15988971316"
			},
			{
				Cost = 3000,
				HealthIncrease = 300,
				DamageIncrease = 32,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				SplashRadiusIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.GrenadierNapalmGrenadeL1 },
				Description = "Stiel Grenade",
				Icon = "rbxassetid://15978642510",
				UpgradeIcon = "rbxassetid://15988971046"
			},
			{
				Cost = 14500,
				HealthIncrease = 1500,
				DamageIncrease = 136,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				SplashRadiusIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.GrenadierNapalmGrenadeL2 },
				Description = "X13-Flash",
				Icon = "rbxassetid://15978642202",
				UpgradeIcon = "rbxassetid://15988970662"
			}
		},
		Path2Data = {
			{
				Cost = 300,
				HealthIncrease = 25,
				DamageIncrease = 4,
				SplashRadiusIncrease = 0.5,
				RangeIncrease = 0,
				Description = "HE Grenades",
				Icon = "rbxassetid://15978643296",
				UpgradeIcon = "rbxassetid://15988971418"
			},
			{
				Cost = 675,
				HealthIncrease = 45,
				DamageIncrease = 8,
				RangeIncrease = 1,
				Description = "Extra Shrapnel",
				Icon = "rbxassetid://15978643132",
				UpgradeIcon = "rbxassetid://15988971752"
			},
			{
				Cost = 2150,
				HealthIncrease = 250,
				DamageIncrease = 23,
				ReloadTimeDecrease = -0.5,
				RangeIncrease = 2,
				SplashRadiusIncrease = 0,
				SplashMaximumTargetsHitOverride = 3,
				StunType = Enums.StunTypes.GrenadierShock,
				StunDurationIncrease = 0.6,
				Description = "Stun Explosive",
				Icon = "rbxassetid://15978642976",
				UpgradeIcon = "rbxassetid://15988970857"
			},
			{
				Cost = 5250,
				HealthIncrease = 375,
				ProjectileName = Enums.Projectiles.GrenadierGrenadeFlat,
				DamageIncrease = 40,
				ReloadTimeDecrease = 0,
				SplashRadiusIncrease = 0.5,
				SplashMaximumTargetsHitOverride = 4,
				StunDurationIncrease = 0.25,
				RangeIncrease = 1,
				Description = "Advanced Shocks",
				Icon = "rbxassetid://15978642677",
				UpgradeIcon = "rbxassetid://15988971978"
			},
			{
				Cost = 17250,
				HealthIncrease = 2000,
				ProjectileName = Enums.Projectiles.GrenadierGrenadeStick,
				DamageIncrease = 140,
				ReloadTimeDecrease = 0,
				GainStealthDetection = true,
				RangeIncrease = 2,
				SplashRadiusIncrease = 0,
				SplashMaximumTargetsHitOverride = 5,
				StunDurationIncrease = 0.5,
				Description = "Shock Trooper",
				Icon = "rbxassetid://15978642372",
				UpgradeIcon = "rbxassetid://15988971220"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	MaxObstacleHeight = 2.5,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 125,
			CostIncreasePerLevel = 75,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 125,
			CostIncreasePerLevel = 175,
			Amount = 1.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 100,
			CostIncreasePerLevel = 75,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 100,
			CostIncreasePerLevel = 100,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.StunDuration,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		}
	}
}