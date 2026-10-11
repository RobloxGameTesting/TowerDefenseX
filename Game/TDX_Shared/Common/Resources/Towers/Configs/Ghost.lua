local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Ghost = {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 750,
			Health = 135,
			CanTargetAir = true,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 2,
			ReloadTime = 0.3,
			Range = 10,
			StealthDetection = false,
			Description = "TODO",
			Icon = "rbxassetid://18729419116"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 550,
				HealthIncrease = 25,
				DamageIncrease = 0,
				GainStealthDetection = true,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3.5,
				Description = "Eye Sensor",
				Icon = "rbxassetid://18729418908",
				UpgradeIcon = "rbxassetid://18731246644"
			},
			{
				Cost = 900,
				HealthIncrease = 55,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 0,
				Description = "Faster Firing",
				Icon = "rbxassetid://18729418726",
				UpgradeIcon = "rbxassetid://18731246499"
			},
			{
				Cost = 3750,
				HealthIncrease = 125,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 4,
				GainStealth = true,
				RegainStealthIfRevealed = true,
				TimeToRegainStealthOverride = 3.5,
				Description = "Stealth Assault",
				Icon = "rbxassetid://18729418168",
				UpgradeIcon = "rbxassetid://18731245994"
			},
			{
				Cost = 12750,
				HealthIncrease = 600,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0.02,
				RangeIncrease = 0,
				TimeToRegainStealthOverride = 2.5,
				AbilityNames = { Enums.TowerAbilities.GhostC7DroneLevel1 },
				Description = "C7 Drone",
				Icon = "rbxassetid://18729417745",
				UpgradeIcon = "rbxassetid://18731352745"
			},
			{
				Cost = 28000,
				HealthIncrease = 900,
				DamageIncrease = 10.5,
				ReloadTimeDecrease = 0.01,
				RangeIncrease = 2,
				TimeToRegainStealthOverride = 1.5,
				AbilityNames = { Enums.TowerAbilities.GhostC7DroneLevel2 },
				Description = "X-Ghost",
				Icon = "rbxassetid://18729417317",
				UpgradeIcon = "rbxassetid://18731245150"
			}
		},
		Path2Data = {
			{
				Cost = 450,
				HealthIncrease = 25,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "+P Ammo",
				Icon = "rbxassetid://18729418908",
				UpgradeIcon = "rbxassetid://18731246221"
			},
			{
				Cost = 950,
				HealthIncrease = 50,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				Description = "Extended Barrel",
				Icon = "rbxassetid://18729418726",
				UpgradeIcon = "rbxassetid://18731246794"
			},
			{
				Cost = 8000,
				HealthIncrease = 500,
				DamageIncrease = 10,
				ReloadTimeDecrease = 0,
				GainStealth = true,
				RegainStealthIfRevealed = true,
				TimeToRegainStealthOverride = 45,
				RangeIncrease = 11,
				Description = "Honey Badger",
				Icon = "rbxassetid://18729418452",
				UpgradeIcon = "rbxassetid://18731246358"
			},
			{
				Cost = 21000,
				HealthIncrease = 800,
				DamageIncrease = 22,
				RegainStealthIfRevealed = true,
				TimeToRegainStealthOverride = 40,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.GhostGrenadeLevel1 },
				Description = "Stealth Grenade",
				Icon = "rbxassetid://18729418015",
				UpgradeIcon = "rbxassetid://18731245465"
			},
			{
				Cost = 40000,
				HealthIncrease = 1500,
				DamageIncrease = 37,
				RegainStealthIfRevealed = true,
				TimeToRegainStealthOverride = 35,
				ReloadTimeDecrease = 0.05,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.GhostGrenadeLevel2 },
				Description = "World's Deadliest",
				Icon = "rbxassetid://18729417539",
				UpgradeIcon = "rbxassetid://18731245360"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.22,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
}
Ghost.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 100,
		CostIncreasePerLevel = 50,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 150,
		CostIncreasePerLevel = 100,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		Cost = 125,
		CostIncreasePerLevel = 100,
		Amount = 0.1
	},
	{
		Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
		Cost = 200,
		CostIncreasePerLevel = 100,
		Amount = 0.1
	}
}
return Ghost