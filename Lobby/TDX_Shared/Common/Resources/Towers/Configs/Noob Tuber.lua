local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.NoobTuberBlast,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 0.5,
	VarianceY = 0.25
}
local clientHitEffectData2 = {
	EffectName = Enums.VisualEffects.NoobTuberBlastRapidFire,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 0.5,
	VarianceY = 0.25
}
return {
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 775,
			Health = 300,
			DamageType = Enums.DamageTypes.Explosive,
			IsSplash = true,
			SplashRadius = 2,
			Damage = 16,
			ReloadTime = 3.5,
			Range = 16,
			StealthDetection = false,
			BurstSize = 1,
			BurstInterval = 0.5,
			BurstEndTriggerFullReload = true,
			ClientHitEffectData = clientHitEffectData,
			Description = "",
			Icon = ""
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 300,
				HealthIncrease = 70,
				DamageIncrease = 0,
				ReloadTimeDecrease = 1,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0,
				ClientHitEffectData = clientHitEffectData,
				Description = "FASTER RELOAD",
				Icon = "",
				UpgradeIcon = "rbxassetid://114191798295571"
			},
			{
				Cost = 1000,
				HealthIncrease = 120,
				DamageIncrease = 0,
				ReloadTimeDecrease = -2.5,
				RangeIncrease = 3,
				BurstSizeIncrease = 5,
				ClientHitEffectData = clientHitEffectData,
				Description = "MGL",
				Icon = "",
				UpgradeIcon = "rbxassetid://106275762994419"
			},
			{
				Cost = 2000,
				HealthIncrease = 250,
				DamageIncrease = 8,
				ReloadTimeDecrease = 1,
				RangeIncrease = 4,
				GainStealthDetection = true,
				ClientHitEffectData = clientHitEffectData,
				Description = "IR SENSOR",
				Icon = "",
				UpgradeIcon = "rbxassetid://80654280345133"
			},
			{
				Cost = 6900,
				HealthIncrease = 475,
				DamageIncrease = 2,
				ReloadTimeDecrease = -3,
				BurstSizeIncrease = 34,
				BurstIntervalOverride = 0.2,
				ClientHitEffectData = clientHitEffectData2,
				Description = "TURRET",
				Icon = "",
				UpgradeIcon = "rbxassetid://78674283714641"
			},
			{
				Cost = 25500,
				HealthIncrease = 1010,
				DamageIncrease = 24,
				ReloadTimeDecrease = 2,
				BurstSizeIncrease = 40,
				DynamicPriceScaling = 50,
				RangeIncrease = 7,
				BurstIntervalOverride = 0.15,
				ClientHitEffectData = clientHitEffectData2,
				Description = "X-TURRET",
				Icon = "",
				UpgradeIcon = "rbxassetid://74225938849816"
			}
		}
	},
	ReplicateReloading = true,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.256,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 75,
			CostIncreasePerLevel = 25,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 150,
			CostIncreasePerLevel = 125,
			Amount = 1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 125,
			CostIncreasePerLevel = 50,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 225,
			CostIncreasePerLevel = 100,
			Amount = 0.25
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://101169158696716"
}