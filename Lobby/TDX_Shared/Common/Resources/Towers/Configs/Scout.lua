local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 250,
			Health = 100,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 4,
			ReloadTime = 1,
			Range = 6,
			StealthDetection = false,
			BurstSize = 1,
			BurstInterval = 0.25,
			Description = "BASE",
			Icon = ""
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 100,
				HealthIncrease = 25,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3.5,
				Description = "Binoculars",
				Icon = "",
				UpgradeIcon = "rbxassetid://93258674262591"
			},
			{
				Cost = 350,
				HealthIncrease = 50,
				DamageIncrease = 1,
				ReloadTimeDecrease = 0.4,
				RangeIncrease = 0,
				Description = "Quick Hands",
				Icon = "",
				UpgradeIcon = "rbxassetid://138537761385471"
			},
			{
				Cost = 925,
				HealthIncrease = 150,
				DamageIncrease = 7,
				GainStealthDetection = true,
				Description = "Recon Training",
				Icon = "",
				UpgradeIcon = "rbxassetid://97333091697538"
			},
			{
				Cost = 4000,
				HealthIncrease = 400,
				DamageIncrease = 23,
				GainCanTargetAir = true,
				RangeIncrease = 2.5,
				Description = "Marksman",
				Icon = "",
				UpgradeIcon = "rbxassetid://121195457851800"
			},
			{
				Cost = 12070,
				HealthIncrease = 1000,
				DamageIncrease = 37,
				ReloadTimeDecrease = 0.2,
				BurstSizeIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.ScoutRecon },
				Description = "Dual Wield",
				Icon = "",
				UpgradeIcon = "rbxassetid://86097674766192"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	SpecialBurstHandlingForModel = true,
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 325,
			CostIncreasePerLevel = 150,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 225,
			CostIncreasePerLevel = 150,
			Amount = 0.15
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://126471888126033"
}