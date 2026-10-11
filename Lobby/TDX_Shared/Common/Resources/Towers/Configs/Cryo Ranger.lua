local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 295,
			Health = 100,
			DamageType = Enums.DamageTypes.Ice,
			Damage = 1,
			ReloadTime = 1.75,
			Range = 9,
			StealthDetection = false,
			BodyHeatReduction = 1.5,
			DamageMultiplierIfFrozen = 1,
			FrozenEnemyDamageMultiplier = 1,
			PermanentSpeedMultiplierIfFrozen = 1,
			BurstSize = 3,
			BurstInterval = 0.15,
			Description = "BASE",
			Icon = "rbxassetid://15722142706"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 150,
				HealthIncrease = 10,
				DamageIncrease = 0.5,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 1,
				BurstSizeIncrease = 1,
				Description = "Advanced Training",
				Icon = "rbxassetid://15722142526",
				UpgradeIcon = "rbxassetid://15728082434"
			},
			{
				Cost = 175,
				HealthIncrease = 15,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 4,
				Description = "Extended Barrel",
				Icon = "rbxassetid://15722142326",
				UpgradeIcon = "rbxassetid://15728082102"
			},
			{
				Cost = 800,
				HealthIncrease = 65,
				DamageIncrease = 1,
				ReloadTimeDecrease = 0.35,
				BurstSizeIncrease = 2,
				RangeIncrease = 2,
				GainStealthDetection = true,
				BodyHeatReductionIncrease = 3,
				Description = "Stealth Sensor Eye",
				Icon = "rbxassetid://15722141853",
				UpgradeIcon = "rbxassetid://15728081397"
			},
			{
				Cost = 3450,
				HealthIncrease = 175,
				DamageIncrease = 6.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				BodyHeatReductionIncrease = 4.5,
				FrozenEnemyDamageMultiplierIncrease = 0.1,
				Description = "Nitrogen Rounds",
				Icon = "rbxassetid://15722141341",
				UpgradeIcon = "rbxassetid://15728081513"
			},
			{
				Cost = 10440,
				HealthIncrease = 675,
				DamageIncrease = 9.5,
				ReloadTimeDecrease = 0.1,
				CanFreezeBoss = true,
				RangeIncrease = 3,
				RemoveBurst = true,
				OverrideReloadTime = 0.15,
				BodyHeatReductionIncrease = 4,
				FrozenEnemyDamageMultiplierIncrease = 0.1,
				PermanentSpeedMultiplierIfFrozenIncrease = -0.1,
				Description = "Ice LMG",
				Icon = "rbxassetid://15722140952",
				UpgradeIcon = "rbxassetid://15728081633"
			}
		},
		Path2Data = {
			{
				Cost = 150,
				HealthIncrease = 15,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Heavy Rounds",
				Icon = "rbxassetid://15722142526",
				UpgradeIcon = "rbxassetid://11425688833"
			},
			{
				Cost = 380,
				HealthIncrease = 25,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.65,
				RangeIncrease = 2,
				BodyHeatReductionIncrease = 1.5,
				Description = "Internal Upgrades",
				Icon = "rbxassetid://15722142326",
				UpgradeIcon = "rbxassetid://11425688567"
			},
			{
				Cost = 2000,
				HealthIncrease = 255,
				DamageIncrease = 3.5,
				ReloadTimeDecrease = 0.25,
				RangeIncrease = 1,
				BurstSizeIncrease = 1,
				BodyHeatReductionIncrease = 4.5,
				AbilityNames = { Enums.TowerAbilities.CryoGrenadeP2L3 },
				Description = "Ice Grenade",
				Icon = "rbxassetid://15722142101",
				UpgradeIcon = "rbxassetid://15728081749"
			},
			{
				Cost = 7500,
				HealthIncrease = 325,
				DamageIncrease = 5,
				ReloadTimeDecrease = 0,
				IgnoreIceResistance = true,
				RangeIncrease = 2,
				BurstSizeIncrease = 3,
				BodyHeatReductionIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.CryoGrenadeP2L4, Enums.TowerAbilities.CryoM203P2L4 },
				Description = "Ice Assault Loadout",
				Icon = "rbxassetid://15722141534",
				UpgradeIcon = "rbxassetid://15728081901"
			},
			{
				Cost = 14000,
				HealthIncrease = 825,
				DamageIncrease = 10,
				ReloadTimeDecrease = 0,
				CanFreezeBoss = true,
				RangeIncrease = 0,
				BurstSizeIncrease = 1,
				BodyHeatReductionIncrease = 5.5,
				DamageMultiplierIfFrozenIncrease = 0.1,
				AbilityNames = { Enums.TowerAbilities.CryoGrenadeP2L5, Enums.TowerAbilities.CryoM203P2L5 },
				Description = "Deep Freeze Loadout",
				Icon = "rbxassetid://15722141221",
				UpgradeIcon = "rbxassetid://15728082250"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Freeze,
			Cost = 200,
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
}