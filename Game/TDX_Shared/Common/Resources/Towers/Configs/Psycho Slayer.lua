local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 4, 3, 2, 2 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 3000,
			Health = 1800,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 20,
			ReloadTime = 0.8,
			IgnoreResistance = true,
			Range = 15,
			StealthDetection = false,
			AbilityNames = { Enums.TowerAbilities.PsychoSlayerMeleeL0 },
			Description = "",
			Icon = "rbxassetid://136578531197111"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 2800,
				HealthIncrease = 850,
				DamageIncrease = 10,
				ReloadTimeDecrease = 0.2,
				AbilityNames = { Enums.TowerAbilities.PsychoSlayerTeleportL1, Enums.TowerAbilities.PsychoSlayerMeleeL1 },
				Description = "Enhanced Suit",
				Icon = "rbxassetid://108236353290368",
				UpgradeIcon = "rbxassetid://130034806334123"
			},
			{
				Cost = 7250,
				HealthIncrease = 1800,
				DamageIncrease = 20,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.PsychoSlayerTeleportL2, Enums.TowerAbilities.PsychoSlayerMeleeL2 },
				Description = "Core Armor",
				Icon = "rbxassetid://118233558334682",
				UpgradeIcon = "rbxassetid://105149844754485"
			},
			{
				Cost = 27000,
				HealthIncrease = 2900,
				DamageIncrease = 40,
				RangeIncrease = 5,
				AbilityNames = {
					Enums.TowerAbilities.PsychoSlayerTeleportL3,
					Enums.TowerAbilities.PsychoSlayerMeleeL3,
					Enums.TowerAbilities.PsychoSlayerRailgunL3
				},
				Description = "Rail Guns",
				Icon = "rbxassetid://105698438637056",
				UpgradeIcon = "rbxassetid://131514711454476"
			},
			{
				Cost = 43000,
				HealthIncrease = 9250,
				DamageIncrease = 60,
				ReloadTimeDecrease = 0.1,
				GainStunImmunity = true,
				RangeIncrease = 0,
				AbilityNames = {
					Enums.TowerAbilities.PsychoSlayerJumpL4,
					Enums.TowerAbilities.PsychoSlayerMeleeL4,
					Enums.TowerAbilities.PsychoSlayerRailgunL4,
					Enums.TowerAbilities.PsychoSlayerRocketsL4
				},
				Description = "Space Suit",
				Icon = "rbxassetid://85661716106714",
				UpgradeIcon = "rbxassetid://82054424836163"
			},
			{
				Cost = 300000,
				HealthIncrease = 50000,
				DamageIncrease = 400,
				GainStealthDetection = true,
				ReloadTimeDecrease = 0.1,
				AbilityNames = {
					Enums.TowerAbilities.PsychoSlayerJumpL5,
					Enums.TowerAbilities.PsychoSlayerMeleeL5,
					Enums.TowerAbilities.PsychoSlayerRailgunL5,
					Enums.TowerAbilities.PsychoSlayerRocketsL5,
					Enums.TowerAbilities.PsychoSlayerMortar
				},
				Description = "PSYCHO WARRIOR",
				Icon = "rbxassetid://100745568601734",
				UpgradeIcon = "rbxassetid://82546584195072"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 2.3,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 175,
			CostIncreasePerLevel = 150,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 500,
			CostIncreasePerLevel = 400,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 100,
			CostIncreasePerLevel = 75,
			Amount = 0.15
		}
	}
}