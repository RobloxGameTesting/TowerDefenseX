local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AttackDisabled = true,
	CreateHealHandler = true,
	LimitMap = { 12, 7, 6, 6 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 500,
			Health = 350,
			DamageType = Enums.DamageTypes.Healing,
			Damage = 0,
			HealAmount = 10,
			ReloadTime = 0.2,
			Range = 12,
			StealthDetection = false,
			Description = "TODO",
			Icon = "rbxassetid://17673683754",
			NoShowDPS = true
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 400,
				HealthIncrease = 50,
				HealAmountIncrease = 4,
				RangeIncrease = 2,
				Description = "Healing Cells",
				Icon = "rbxassetid://17673683547",
				UpgradeIcon = "rbxassetid://17684202449"
			},
			{
				Cost = 825,
				HealthIncrease = 70,
				HealAmountIncrease = 7,
				RangeIncrease = 0,
				Description = "Bigger Beam",
				Icon = "rbxassetid://17673683254",
				UpgradeIcon = "rbxassetid://17684202875"
			},
			{
				Cost = 3000,
				HealthIncrease = 200,
				HealAmountIncrease = 15,
				RangeIncrease = 2,
				Description = "Advanced MediGun",
				Icon = "rbxassetid://17673682757",
				UpgradeIcon = "rbxassetid://17684203458"
			},
			{
				Cost = 8000,
				HealthIncrease = 475,
				HealAmountIncrease = 30,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.MedicGodModeLevel1 },
				Description = "UBER Charge",
				Icon = "rbxassetid://17673682219",
				UpgradeIcon = "rbxassetid://17684201366"
			},
			{
				Cost = 29000,
				HealthIncrease = 1400,
				GainStunImmunity = true,
				HealAmountIncrease = 80,
				RangeIncrease = 12,
				AbilityNames = { Enums.TowerAbilities.MedicGodModeLevel2 },
				Description = "MAX UBER",
				Icon = "rbxassetid://17673681869",
				UpgradeIcon = "rbxassetid://17684201567"
			}
		},
		Path2Data = {
			{
				Cost = 125,
				HealthIncrease = 35,
				HealAmountIncrease = 0,
				RangeIncrease = 2,
				Description = "Extended Range",
				Icon = "rbxassetid://17673683547",
				UpgradeIcon = "rbxassetid://17684202560"
			},
			{
				Cost = 300,
				HealthIncrease = 50,
				HealAmountIncrease = 0,
				RangeIncrease = 3,
				Description = "Lasting Cells",
				Icon = "rbxassetid://17673683254",
				UpgradeIcon = "rbxassetid://17684201974"
			},
			{
				Cost = 2975,
				HealthIncrease = 100,
				HealAmountIncrease = 5,
				RangeIncrease = 9,
				Description = "Longer Range",
				Icon = "rbxassetid://17673683006",
				UpgradeIcon = "rbxassetid://17684201736"
			},
			{
				Cost = 9250,
				HealthIncrease = 300,
				HealAmountIncrease = 25,
				GainStunImmunity = true,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.MedicKritzLevel1 },
				Description = "Damage Charge",
				Icon = "rbxassetid://17673682502",
				UpgradeIcon = "rbxassetid://17684202725"
			},
			{
				Cost = 28000,
				HealthIncrease = 1200,
				HealAmountIncrease = 40,
				RangeIncrease = 5,
				GainStunImmunity = true,
				AbilityNames = { Enums.TowerAbilities.MedicKritzLevel2 },
				Description = "KRITZ",
				Icon = "rbxassetid://17673682007",
				UpgradeIcon = "rbxassetid://17684202235"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DisallowedBuffTypesMap = { [Enums.TowerBuffTypes.Firerate] = true },
	BeamEffectForHeal = true,
	DefaultBeamEffectHandlingData = {
		{
			BeamParentInstancePath = { "Gun", "Main" },
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		}
	},
	PrimaryMinorStat = {
		Key = "HealingDealt",
		Icon = "rbxassetid://17664702175",
		FormatString = "%d"
	},
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 50,
			CostIncreasePerLevel = 25,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Heal,
			Cost = 150,
			CostIncreasePerLevel = 250,
			Amount = 0.35
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 175,
			CostIncreasePerLevel = 25,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 150,
			CostIncreasePerLevel = 150,
			Amount = 0.15
		}
	}
}