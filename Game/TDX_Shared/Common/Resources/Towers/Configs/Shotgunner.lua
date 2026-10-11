local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 250,
			Health = 75,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 6,
			ReloadTime = 1.75,
			Range = 7,
			StealthDetection = false,
			ArcSpreadAngle = 38,
			ArcMaximumTargetsHit = 3,
			Description = "BASE",
			Icon = "rbxassetid://17307832637"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 120,
				HealthIncrease = 10,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.3,
				RangeIncrease = 1,
				Description = "Gloves",
				Icon = "rbxassetid://17307832410",
				UpgradeIcon = "rbxassetid://17307808363"
			},
			{
				Cost = 225,
				HealthIncrease = 35,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 1,
				Description = "Padded Vest",
				Icon = "rbxassetid://17307831922",
				UpgradeIcon = "rbxassetid://17307809656"
			},
			{
				Cost = 1250,
				HealthIncrease = 125,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 0,
				ArcSpreadAngleIncrease = 7,
				ArcMaximumTargetsHitIncrease = 1,
				Description = "Militant",
				Icon = "rbxassetid://17307834960",
				UpgradeIcon = "rbxassetid://17307808129"
			},
			{
				Cost = 2400,
				HealthIncrease = 225,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.25,
				GainStealthDetection = true,
				RangeIncrease = 1,
				ArcMaximumTargetsHitIncrease = 3,
				Description = "Advanced Goggles",
				Icon = "rbxassetid://17307834541",
				UpgradeIcon = "rbxassetid://17307809066"
			},
			{
				Cost = 11000,
				HealthIncrease = 650,
				DamageIncrease = 16,
				ReloadTimeDecrease = 0.4,
				RangeIncrease = 0,
				ArcSpreadAngleIncrease = 10,
				ArcMaximumTargetsHitIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.ShotgunnerHealingField },
				Description = "AA-12",
				Icon = "rbxassetid://17307834029",
				UpgradeIcon = "rbxassetid://12734606082"
			}
		},
		Path2Data = {
			{
				Cost = 80,
				HealthIncrease = 50,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				Description = "Shotgun Knowledge",
				Icon = "rbxassetid://17307832410",
				UpgradeIcon = "rbxassetid://17307809440"
			},
			{
				Cost = 245,
				HealthIncrease = 5,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Bigger Buckshot",
				Icon = "rbxassetid://17307831922",
				UpgradeIcon = "rbxassetid://17307808753"
			},
			{
				Cost = 950,
				HealthIncrease = 375,
				DamageIncrease = 6,
				ReloadTimeDecrease = -0.3,
				RangeIncrease = 2,
				ArcSpreadAngleIncrease = -8,
				GainCanTargetAir = true,
				ArcMaximumTargetsHitIncrease = 1,
				Description = "Officer",
				Icon = "rbxassetid://17307834714",
				UpgradeIcon = "rbxassetid://17307809854"
			},
			{
				Cost = 2800,
				HealthIncrease = 425,
				DamageIncrease = 20,
				ReloadTimeDecrease = 0,
				ArcMaximumTargetsHitIncrease = 1,
				GainIgnoreResistance = true,
				RangeIncrease = 1,
				ArcSpreadAngleIncrease = -5,
				Description = "SWAT Equipment",
				Icon = "rbxassetid://17307834344",
				UpgradeIcon = "rbxassetid://17307809266"
			},
			{
				Cost = 13000,
				HealthIncrease = 1425,
				DamageIncrease = 160,
				ReloadTimeDecrease = 0.15,
				RangeIncrease = 0,
				ArcMaximumTargetsHitIncrease = 6,
				ArcSpreadAngleIncrease = -5,
				AbilityNames = { Enums.TowerAbilities.ShotgunnerUnstunField },
				Description = "DB-12",
				Icon = "rbxassetid://17307833695",
				UpgradeIcon = "rbxassetid://17307808524"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Shotgun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, 0, 0),
	SetUpKeyframeReachedEventForAttack = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 125,
			CostIncreasePerLevel = 100,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 100,
			CostIncreasePerLevel = 100,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 75,
			CostIncreasePerLevel = 65,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 50,
			CostIncreasePerLevel = 10,
			Amount = 0.15
		}
	}
}