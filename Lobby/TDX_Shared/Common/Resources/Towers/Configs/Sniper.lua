local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 285,
			Health = 100,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 8,
			ReloadTime = 2.75,
			Range = 21,
			StealthDetection = false,
			CanTargetAir = true,
			Description = "BASE",
			Icon = "rbxassetid://15246006524"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 300,
				HealthIncrease = 10,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.75,
				RangeIncrease = 4,
				Description = "Advanced Training",
				Icon = "rbxassetid://15240898255",
				UpgradeIcon = "rbxassetid://15245966677"
			},
			{
				Cost = 425,
				HealthIncrease = 15,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 6,
				GainStealthDetection = true,
				Description = "Enhanced Sight",
				Icon = "rbxassetid://15240898168",
				UpgradeIcon = "rbxassetid://15245966377"
			},
			{
				Cost = 2800,
				HealthIncrease = 50,
				DamageIncrease = 21,
				ReloadTimeDecrease = 0.2,
				RangeIncrease = 2,
				Description = "Intervention",
				PierceCountIncrease = 1,
				Icon = "rbxassetid://15240897991",
				UpgradeIcon = "rbxassetid://15245966012"
			},
			{
				Cost = 3450,
				HealthIncrease = 170,
				DamageIncrease = 35,
				ReloadTimeDecrease = -0.3,
				RangeIncrease = 3,
				GainStealth = true,
				RegainStealthIfRevealed = true,
				TimeToRegainStealthOverride = 7,
				GainIgnoreResistance = true,
				Description = "AP Bullets",
				Icon = "rbxassetid://15240897807",
				UpgradeIcon = "rbxassetid://15245966504"
			},
			{
				Cost = 14250,
				ProjectileName = Enums.Projectiles.NTW20Bullet,
				HealthIncrease = 700,
				DamageIncrease = 150,
				ReloadTimeDecrease = -0.6,
				TimeToRegainStealthOverride = 4,
				RangeIncrease = 3,
				PierceCountIncrease = 1,
				Description = "Pathfinder",
				Icon = "rbxassetid://15240897525",
				UpgradeIcon = "rbxassetid://15245965137"
			}
		},
		Path2Data = {
			{
				Cost = 300,
				HealthIncrease = 15,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "High Velocity",
				Icon = "rbxassetid://15240898255",
				UpgradeIcon = "rbxassetid://15245966188"
			},
			{
				Cost = 1250,
				HealthIncrease = 20,
				DamageIncrease = 12,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "160 GR Bullet",
				Icon = "rbxassetid://15240898168",
				UpgradeIcon = "rbxassetid://15245966855"
			},
			{
				Cost = 2850,
				HealthIncrease = 80,
				DamageIncrease = 5,
				ReloadTimeDecrease = 1,
				RangeIncrease = 2,
				Description = "Marksman",
				Icon = "rbxassetid://15240899248",
				UpgradeIcon = "rbxassetid://15245965285"
			},
			{
				Cost = 4350,
				HealthIncrease = 185,
				DamageIncrease = 18,
				ReloadTimeDecrease = 0,
				RangeIncrease = 18,
				AbilityNames = { Enums.TowerAbilities.FlareGun },
				Description = "Laser Eye",
				Icon = "rbxassetid://15240899051",
				UpgradeIcon = "rbxassetid://15245965559"
			},
			{
				Cost = 17250,
				ProjectileName = Enums.Projectiles.LaserBarrettBeam,
				HealthIncrease = 625,
				DamageIncrease = 120,
				DamageType = Enums.DamageTypes.Laser,
				ReloadTimeDecrease = -0.25,
				PierceCountIncrease = 1,
				RangeIncrease = 22,
				AbilityNames = { Enums.TowerAbilities.FlareGun },
				Description = "Laser Barrett",
				Icon = "rbxassetid://15240898884",
				UpgradeIcon = "rbxassetid://15245965813"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Sniper",
	MaxObstacleHeight = 1.6,
	HasCustomCode = true,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	CustomQueryOptions = { "FirstWithAbility", "First", "Last", "Strongest", "Weakest", "Random" },
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 75,
			CostIncreasePerLevel = 50,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 185,
			CostIncreasePerLevel = 75,
			Amount = 0.35
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 85,
			CostIncreasePerLevel = 20,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Firerate,
			Cost = 50,
			CostIncreasePerLevel = 125,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Pierce,
			Cost = 50,
			CostIncreasePerLevel = 50,
			Amount = 1,
			OverrideMaxLevel = 3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 30,
			CostIncreasePerLevel = 20,
			Amount = 0.05
		}
	}
}