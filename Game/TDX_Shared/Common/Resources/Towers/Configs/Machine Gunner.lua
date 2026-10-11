local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 900,
			Health = 400,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 2.5,
			ReloadTime = 0.2,
			Range = 24,
			StealthDetection = false,
			MaximumROM = 110,
			Description = "",
			Icon = "rbxassetid://99206588553623",
			AbilityNames = { Enums.TowerAbilities.MachineGunnerRedeploy }
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 1175,
				HealthIncrease = 10,
				DamageIncrease = 2,
				RangeIncrease = 3,
				Description = "Heavy Ammo",
				Icon = "rbxassetid://88903166537328",
				UpgradeIcon = "rbxassetid://11425688833",
				AbilityNames = { Enums.TowerAbilities.MachineGunnerRedeploy }
			},
			{
				Cost = 1100,
				HealthIncrease = 25,
				DamageIncrease = 2,
				Description = "Piercing Rounds",
				Icon = "rbxassetid://121821249248745",
				UpgradeIcon = "rbxassetid://90284571769576",
				AbilityNames = { Enums.TowerAbilities.MachineGunnerRedeploy }
			},
			{
				Cost = 6250,
				HealthIncrease = 175,
				DamageIncrease = 2.5,
				MaximumROMIncrease = 20,
				ReloadTimeDecrease = 0.05,
				PierceCountIncrease = 1,
				Description = "Browning MG",
				Icon = "rbxassetid://129428585463891",
				UpgradeIcon = "rbxassetid://73224470173808",
				AbilityNames = { Enums.TowerAbilities.MachineGunnerRedeploy }
			},
			{
				Cost = 12000,
				HealthIncrease = 850,
				MaximumROMIncrease = 10,
				DamageIncrease = 8.5,
				GainCanTargetAir = true,
				Description = "Double Barrel",
				Icon = "rbxassetid://130343504086867",
				UpgradeIcon = "rbxassetid://88370660295563",
				AbilityNames = { Enums.TowerAbilities.MachineGunnerRedeploy }
			},
			{
				Cost = 58250,
				HealthIncrease = 1800,
				MaximumROMIncrease = 80,
				DamageIncrease = 33.5,
				PierceCountIncrease = 1,
				GainStunImmunity = true,
				Description = "AA Turret",
				Icon = "rbxassetid://127600680087812",
				UpgradeIcon = "rbxassetid://91391982457700",
				AbilityNames = { Enums.TowerAbilities.MachineGunnerRedeploy }
			}
		},
		Path2Data = {
			{
				Cost = 700,
				HealthIncrease = 10,
				ReloadTimeDecrease = 0.05,
				Description = "Faster Firing",
				Icon = "rbxassetid://88903166537328",
				UpgradeIcon = "rbxassetid://11425688567",
				AbilityNames = { Enums.TowerAbilities.MachineGunnerRedeploy }
			},
			{
				Cost = 800,
				HealthIncrease = 25,
				DamageIncrease = 1,
				RangeIncrease = 5,
				Description = "Extended Barrels",
				Icon = "rbxassetid://121821249248745",
				UpgradeIcon = "rbxassetid://128017408397292",
				AbilityNames = { Enums.TowerAbilities.MachineGunnerRedeploy }
			},
			{
				Cost = 10000,
				HealthIncrease = 450,
				MaximumROMIncrease = -20,
				DamageIncrease = 13,
				ReloadTimeDecrease = -0.1,
				RangeIncrease = 12,
				DamageType = Enums.DamageTypes.Laser,
				GainStealthDetection = true,
				PierceCountIncrease = 1,
				Description = "Laser MG",
				Icon = "rbxassetid://110389575771801",
				UpgradeIcon = "rbxassetid://124785802415597",
				AbilityNames = {
					Enums.TowerAbilities.MachineGunnerRedeploy,
					Enums.TowerAbilities.MachineGunnerOvercharge1
				}
			},
			{
				Cost = 16000,
				HealthIncrease = 675,
				DamageIncrease = 26,
				ReloadTimeDecrease = 0,
				RangeIncrease = 6,
				Description = "Laser Cells",
				Icon = "rbxassetid://113590841300385",
				UpgradeIcon = "rbxassetid://113701247119849",
				AbilityNames = {
					Enums.TowerAbilities.MachineGunnerRedeploy,
					Enums.TowerAbilities.MachineGunnerOvercharge2
				}
			},
			{
				Cost = 72000,
				HealthIncrease = 1450,
				MaximumROMIncrease = 10,
				RangeIncrease = 5,
				DamageIncrease = 53.5,
				Description = "OVER CHARGE",
				Icon = "rbxassetid://74920505143478",
				UpgradeIcon = "rbxassetid://104620201647912",
				AbilityNames = {
					Enums.TowerAbilities.MachineGunnerRedeploy,
					Enums.TowerAbilities.MachineGunnerOvercharge3
				}
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	MaxObstacleHeight = 1.6,
	ValidArcsCustomDivisionCount = 80,
	Radius = 2.4,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 0, 0),
	GunModelName = "Character>Gun",
	HasCustomCode = true,
	NoDefaultDeathEffect = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 50,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 250,
			CostIncreasePerLevel = 425,
			Amount = 0.35
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 150,
			CostIncreasePerLevel = 75,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Pierce,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 1,
			OverrideMaxLevel = 3
		}
	}
}