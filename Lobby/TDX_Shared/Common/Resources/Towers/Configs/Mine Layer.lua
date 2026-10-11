local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("ProjectileTypes"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 310,
			Health = 65,
			DamageType = Enums.DamageTypes.Explosive,
			ProjectileName = Enums.Projectiles.Mine,
			TargetRandomLocationOnPath = true,
			SpawnStaticEntityName = Enums.StaticEntities.Mine,
			DamageStatsTransferredToStaticEntity = true,
			StaticEntityLifetime = 35,
			IsSplash = true,
			SplashRadius = 2.5,
			Damage = 20,
			ReloadTime = 12.5,
			Range = 5,
			StealthDetection = false,
			Description = "Base",
			Icon = "rbxassetid://14843348904"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 220,
				HealthIncrease = 5,
				StaticEntityLifetimeIncrease = 0,
				DamageIncrease = 0,
				ReloadTimeDecrease = 2.5,
				RangeIncrease = 0,
				Description = "Faster Arming",
				Icon = "rbxassetid://14843348823",
				UpgradeIcon = "rbxassetid://15266614484"
			},
			{
				Cost = 625,
				HealthIncrease = 15,
				ReloadTimeDecrease = 4,
				RangeIncrease = 0,
				StaticEntityLifetimeIncrease = 8,
				Description = "Advanced Training",
				Icon = "rbxassetid://14843348770",
				UpgradeIcon = "rbxassetid://15266615180"
			},
			{
				Cost = 1950,
				HealthIncrease = 100,
				StaticEntityLifetimeIncrease = 3.5,
				DamageIncrease = 40,
				ReloadTimeDecrease = 1,
				RangeIncrease = 0,
				SplashRadiusIncrease = 1,
				GainStealthDetection = true,
				Description = "Claymore",
				Icon = "rbxassetid://14843348554",
				UpgradeIcon = "rbxassetid://15266614623"
			},
			{
				Cost = 2900,
				HealthIncrease = 275,
				StaticEntityLifetimeIncrease = 3.5,
				DamageIncrease = 70,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0,
				Description = "AP Mine",
				Icon = "rbxassetid://14843348331",
				UpgradeIcon = "rbxassetid://15266614820"
			},
			{
				Cost = 7800,
				HealthIncrease = 725,
				DamageIncrease = 140,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				SplashRadiusIncrease = 1,
				Description = "Super AP Mine",
				Icon = "rbxassetid://14843348113",
				UpgradeIcon = "rbxassetid://15266613996"
			}
		},
		Path2Data = {
			{
				Cost = 250,
				HealthIncrease = 5,
				StaticEntityLifetimeIncrease = 12,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Life Span",
				Icon = "rbxassetid://14843348823",
				UpgradeIcon = "rbxassetid://15266614150"
			},
			{
				Cost = 950,
				HealthIncrease = 10,
				DamageIncrease = 35,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0.5,
				Description = "High Explosive",
				Icon = "rbxassetid://14843348770",
				UpgradeIcon = "rbxassetid://15266614322"
			},
			{
				Cost = 3200,
				HealthIncrease = 150,
				DamageIncrease = 25,
				StaticEntityLifetimeIncrease = 20,
				ReloadTimeDecrease = -1,
				RangeIncrease = 0,
				SplashRadiusIncrease = -0.5,
				Description = "Anti-Tank Mine",
				Icon = "rbxassetid://14843348702",
				UpgradeIcon = "rbxassetid://15266615039"
			},
			{
				Cost = 5200,
				HealthIncrease = 250,
				DamageIncrease = 100,
				StaticEntityLifetimeIncrease = 15,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0,
				GainIgnoreResistance = true,
				Description = "Thermite",
				Icon = "rbxassetid://14843348459",
				UpgradeIcon = "rbxassetid://15266613774",
				BurnEffectStats = {
					Name = Enums.BurnEffects.Thermite,
					DamageType = Enums.DamageTypes.Fire,
					DamagePerSecond = 10,
					Radius = 3.5,
					Duration = 8,
					StickDuration = 12
				}
			},
			{
				Cost = 14000,
				HealthIncrease = 575,
				DamageIncrease = 250,
				StaticEntityLifetimeIncrease = 55,
				ReloadTimeDecrease = -1.5,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0,
				Description = "X-Mine",
				Icon = "rbxassetid://14843348250",
				UpgradeIcon = "rbxassetid://15266613528",
				BurnEffectStats = {
					Name = Enums.BurnEffects.Thermite,
					DamageType = Enums.DamageTypes.Fire,
					DamagePerSecond = 30,
					Radius = 3.5,
					Duration = 8,
					StickDuration = 12
				}
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 100,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 1
		}
	}
}