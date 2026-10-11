local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("ProjectileTypes"))
local Toxicnator = {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 925,
			Health = 200,
			DamageType = Enums.DamageTypes.Toxic,
			ProjectileName = Enums.Projectiles.ToxicGrenadeGreen,
			Damage = 0,
			ReloadTime = 6,
			Range = 10,
			StealthDetection = false,
			Description = "BASE",
			Icon = "rbxassetid://16117095124",
			NoShowDPS = true,
			BurnEffectStats = {
				Name = Enums.BurnEffects.GasCloudGreen,
				DisplayName = "Gas Cloud",
				DamageType = Enums.DamageTypes.Toxic,
				DamagePerSecond = 3,
				Radius = 3,
				Duration = 3,
				StickDuration = 3,
				MaximumTargetsHit = 7,
				OverrideBurnVFXName = "GasGreen",
				VFXYOffset = 1.5
			},
			BurnEffectStatsUpgradable = true
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 375,
				HealthIncrease = 20,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Toxic Research",
				Icon = "rbxassetid://16117095022",
				UpgradeIcon = "rbxassetid://16117103847",
				BurnEffectDamagePerSecondIncrease = 1.5
			},
			{
				Cost = 250,
				HealthIncrease = 25,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				Description = "Advanced Nades",
				Icon = "rbxassetid://16117094937",
				UpgradeIcon = "rbxassetid://16117104557"
			},
			{
				Cost = 1650,
				HealthIncrease = 50,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 0,
				Description = "MGL",
				Icon = "rbxassetid://16117094751",
				UpgradeIcon = "rbxassetid://16117104119",
				BurnEffectNameChange = Enums.BurnEffects.GasCloudGreenLarge,
				BurnEffectDisplayNameChange = "XL Gas Cloud",
				BurnEffectDamagePerSecondIncrease = 2,
				BurnEffectRadiusIncrease = 1.5,
				BurnEffectDurationIncrease = 2,
				OverrideBurnEffectMaximumTargetsHit = 10
			},
			{
				Cost = 2500,
				GainStealthDetection = true,
				HealthIncrease = 250,
				DamageIncrease = 0,
				ReloadTimeDecrease = 1,
				BurnEffectDamagePerSecondIncrease = 1,
				RangeIncrease = 0,
				Description = "Speed Loader",
				Icon = "rbxassetid://16117094621",
				UpgradeIcon = "rbxassetid://16117104003",
				OverrideBurnEffectMaximumTargetsHit = 12
			},
			{
				Cost = 30000,
				HealthIncrease = 825,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Toxic Fumes",
				Icon = "rbxassetid://16117094485",
				UpgradeIcon = "rbxassetid://16117104003",
				BurnEffectDamagePerSecondIncrease = 9,
				BurnEffectStickDurationIncrease = 18,
				OverrideBurnEffectMaximumTargetsHit = 99
			}
		},
		Path2Data = {
			{
				Cost = 150,
				HealthIncrease = 15,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				Description = "Toxic Safety",
				Icon = "rbxassetid://16117095022",
				UpgradeIcon = "rbxassetid://16117103771"
			},
			{
				Cost = 425,
				HealthIncrease = 35,
				DamageIncrease = 0,
				ReloadTimeDecrease = 1,
				RangeIncrease = 0,
				Description = "Higher Dose",
				Icon = "rbxassetid://16117094937",
				UpgradeIcon = "rbxassetid://16117104214",
				BurnEffectDamagePerSecondIncrease = 2
			},
			{
				Cost = 4250,
				HealthIncrease = 250,
				ProjectileName = Enums.Projectiles.ToxicGrenadePurple,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.ToxicBlastLevel1 },
				Description = "Anthrax",
				Icon = "rbxassetid://16117095883",
				UpgradeIcon = "rbxassetid://16117104469",
				BurnEffectNameChange = Enums.BurnEffects.GasCloudPurple,
				BurnEffectDamagePerSecondIncrease = 20.5,
				BurnEffectStickDurationIncrease = 1,
				OverrideBurnEffectDuration = 0.1,
				OverrideBurnEffectMaximumTargetsHit = 3,
				OverrideBurnEffectEnemyBuffNames = { Enums.EnemyBuffs.ToxicnatorResistanceDebuffL1 },
				OverrideBurnVFXName = "GasPurple"
			},
			{
				Cost = 14000,
				HealthIncrease = 525,
				ProjectileName = Enums.Projectiles.ToxicGrenadePurple,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				AbilityNames = { Enums.TowerAbilities.ToxicBlastLevel2 },
				Description = "Acid Meltdown",
				Icon = "rbxassetid://16117095737",
				UpgradeIcon = "rbxassetid://16117104637",
				BurnEffectDamagePerSecondIncrease = 73,
				OverrideBurnEffectDuration = 0.1,
				OverrideBurnEffectMaximumTargetsHit = 3,
				OverrideBurnEffectEnemyBuffNames = { Enums.EnemyBuffs.ToxicnatorResistanceDebuffL2 },
				OverrideBurnVFXName = "GasPurple"
			},
			{
				Cost = 30000,
				HealthIncrease = 1250,
				ProjectileName = Enums.Projectiles.ToxicGrenadePurple,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 1,
				GainStealthDetection = true,
				AbilityNames = { Enums.TowerAbilities.ToxicBlastLevel3 },
				Description = "Gamma Toxins",
				Icon = "rbxassetid://16117095612",
				UpgradeIcon = "rbxassetid://16117104351",
				BurnEffectDamagePerSecondIncrease = 175,
				OverrideBurnEffectDuration = 0.1,
				OverrideBurnEffectMaximumTargetsHit = 3,
				OverrideBurnEffectEnemyBuffNames = { Enums.EnemyBuffs.ToxicnatorResistanceDebuffL3 },
				OverrideBurnVFXName = "GasPurple"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.25,
	RotationOffset = CFrame.Angles(0, 0, 0)
}
Toxicnator.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 50,
		CostIncreasePerLevel = 50,
		Amount = 0.25
	},
	{ Type = Enums.TowerUpgradeShopTypes.Range, Cost = 75, CostIncreasePerLevel = 15, Amount = 0.1 },
	{
		Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
		Cost = 40,
		CostIncreasePerLevel = 5,
		Amount = 0.18
	}
}
return Toxicnator