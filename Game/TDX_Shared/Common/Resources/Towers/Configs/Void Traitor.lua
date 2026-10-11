local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 3000,
			Health = 1400,
			DamageType = Enums.DamageTypes.Melee,
			IsSplash = true,
			SplashRadius = 1.5,
			SplashMaximumTargetsHit = 4,
			Damage = 75,
			DamageDelay = 0.22,
			ReloadTime = 1.5,
			Range = 7,
			StealthDetection = false,
			Description = "TODO",
			Icon = "",
			ApplyBurnStats = {
				DamagePerSecond = 12,
				StickDuration = 3,
				OverrideBurnVFXName = Enums.BurnVFX.VoidBurn
			}
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 1050,
				HealthIncrease = 70,
				DamageIncrease = 25,
				Description = "Sharper Blade",
				Icon = "",
				ApplyBurnStats = {
					DamagePerSecond = 25,
					StickDuration = 3,
					OverrideBurnVFXName = Enums.BurnVFX.VoidBurn
				},
				UpgradeIcon = "rbxassetid://76409626224749"
			},
			{
				Cost = 3000,
				HealthIncrease = 300,
				DamageIncrease = 45,
				GainStunImmunity = true,
				SplashMaximumTargetsHitIncrease = 2,
				Description = "Void Blade",
				Icon = "",
				ApplyBurnStats = {
					DamagePerSecond = 50,
					StickDuration = 3,
					OverrideBurnVFXName = Enums.BurnVFX.VoidBurn
				},
				UpgradeIcon = "rbxassetid://89607555476594"
			},
			{
				Cost = 4000,
				HealthIncrease = 600,
				DamageIncrease = 200,
				GainStealthDetection = true,
				RangeIncrease = 1,
				ApplyBurnStats = {
					DamagePerSecond = 115,
					StickDuration = 3,
					OverrideBurnVFXName = Enums.BurnVFX.VoidBurn
				},
				Description = "All seeing eye",
				Icon = "",
				UpgradeIcon = "rbxassetid://93270872216514"
			},
			{
				Cost = 13000,
				HealthIncrease = 6000,
				DamageIncrease = 225,
				SplashRadiusIncrease = 1,
				Description = "Void Armor",
				ApplyBurnStats = {
					DamagePerSecond = 200,
					StickDuration = 3,
					OverrideBurnVFXName = Enums.BurnVFX.VoidBurn
				},
				Icon = "",
				UpgradeIcon = "rbxassetid://95022565446712"
			},
			{
				Cost = 350000,
				HealthIncrease = 12500,
				ReloadTimeDecrease = -1.25,
				DamageIncrease = 4680,
				SplashRadiusIncrease = 1,
				SplashMaximumTargetsHitIncrease = 8,
				DamageDelayOverride = 0.7,
				AbilityNames = {
					Enums.TowerAbilities.VoidTraitorVoidRift,
					Enums.TowerAbilities.VoidTraitorSummonTroops,
					Enums.TowerAbilities.VoidTraitorSlam
				},
				ApplyBurnStats = {
					DamagePerSecond = 1500,
					StickDuration = 3,
					OverrideBurnVFXName = Enums.BurnVFX.VoidBurn
				},
				Description = "Void Traitor",
				Icon = "",
				UpgradeIcon = "rbxassetid://110588587173030"
			}
		}
	},
	LimitMap = { 4, 2, 1, 1 },
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Sword",
	MaxObstacleHeight = 1.6,
	Radius = 2.2,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	SetUpKeyframeReachedEventForAttack = true,
	HasCustomCode = true,
	DisallowedBuffTypesMap = {
		[Enums.TowerBuffTypes.Range] = true,
		[Enums.TowerBuffTypes.Range2] = true,
		[Enums.TowerBuffTypes.Range3] = true
	},
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 185,
			CostIncreasePerLevel = 110,
			Amount = 0.35
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 325,
			CostIncreasePerLevel = 150,
			Amount = 0.6
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Firerate,
			Cost = 175,
			CostIncreasePerLevel = 100,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 350,
			CostIncreasePerLevel = 125,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 350,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://122898352612538"
}