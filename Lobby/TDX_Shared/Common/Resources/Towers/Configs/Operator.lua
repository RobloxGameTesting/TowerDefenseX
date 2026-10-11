local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Operator = {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 450,
			Health = 150,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 1.5,
			ReloadTime = 0.4,
			Range = 11,
			StealthDetection = false,
			BurstSize = 1,
			BurstInterval = 0.05,
			Description = "BASE",
			Icon = "rbxassetid://15022873474"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 125,
				HealthIncrease = 20,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.05,
				RangeIncrease = 0,
				Description = "Advanced Training",
				Icon = "rbxassetid://15022873386",
				UpgradeIcon = "rbxassetid://15190630696"
			},
			{
				Cost = 240,
				HealthIncrease = 30,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				Description = "Better Equipment",
				Icon = "rbxassetid://15022889023",
				UpgradeIcon = "rbxassetid://15190630558"
			},
			{
				Cost = 1000,
				HealthIncrease = 105,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0.05,
				BurstSizeIncrease = 0,
				RangeIncrease = 3,
				GainStealthDetection = true,
				Description = "Assault Rifle",
				Icon = "rbxassetid://15022873162",
				UpgradeIcon = "rbxassetid://15190619810"
			},
			{
				Cost = 3350,
				HealthIncrease = 250,
				DamageIncrease = 2.5,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 3,
				Description = "Special Forces",
				Icon = "rbxassetid://15022872908",
				UpgradeIcon = "rbxassetid://15190619362"
			},
			{
				Cost = 12750,
				HealthIncrease = 700,
				DamageIncrease = 21.5,
				ReloadTimeDecrease = 0.02,
				RangeIncrease = 2,
				Description = "Ghost",
				Icon = "rbxassetid://15022872717",
				UpgradeIcon = "rbxassetid://15190630254"
			}
		},
		Path2Data = {
			{
				Cost = 275,
				HealthIncrease = 50,
				DamageIncrease = 1.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				BurstSizeIncrease = 0,
				Description = "Armor",
				Icon = "rbxassetid://15022873386",
				UpgradeIcon = "rbxassetid://15190619893"
			},
			{
				Cost = 575,
				HealthIncrease = 25,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				Description = "UMP-45",
				Icon = "rbxassetid://15022889023",
				UpgradeIcon = "rbxassetid://15190630083"
			},
			{
				Cost = 2000,
				HealthIncrease = 250,
				DamageIncrease = 1,
				ReloadTimeDecrease = -0.25,
				RangeIncrease = 0,
				BurstSizeIncrease = 3,
				GainCanTargetAir = true,
				AbilityNames = { Enums.TowerAbilities.SpawnJeep },
				Description = "Jeep Support",
				Icon = "rbxassetid://15022873233",
				UpgradeIcon = "rbxassetid://15190619549"
			},
			{
				Cost = 7000,
				HealthIncrease = 450,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				BurstSizeIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.SpawnJeep, Enums.TowerAbilities.SpawnHumvee },
				Description = "Humvee",
				Icon = "rbxassetid://15022873011",
				UpgradeIcon = "rbxassetid://11425688567"
			},
			{
				Cost = 22000,
				HealthIncrease = 1300,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0.15,
				RangeIncrease = 0,
				BurstSizeIncrease = 4,
				GainStunImmunity = true,
				AbilityNames = { Enums.TowerAbilities.SpawnHumvee, Enums.TowerAbilities.SpawnLAV25 },
				Description = "X-Captain",
				Icon = "rbxassetid://15022888922",
				UpgradeIcon = "rbxassetid://15190630409"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.25,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
}
Operator.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 50,
		CostIncreasePerLevel = 50,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 175,
		CostIncreasePerLevel = 75,
		Amount = 0.3
	},
	{ Type = Enums.TowerUpgradeShopTypes.Range, Cost = 75, CostIncreasePerLevel = 15, Amount = 0.1 },
	{
		Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
		Cost = 40,
		CostIncreasePerLevel = 5,
		Amount = 0.18
	}
}
return Operator