local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 22, 14, 9, 6 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 400,
			Health = 200,
			DamageType = Enums.DamageTypes.Melee,
			IsSplash = true,
			SplashRadius = 1.5,
			SplashMaximumTargetsHit = 3,
			Damage = 8,
			DamageDelay = 0.17,
			ReloadTime = 1.75,
			Range = 4.5,
			BurstSize = 1,
			BurstInterval = 0.8,
			StealthDetection = false,
			BodyHeatReduction = 5,
			PermanentSpeedMultiplierIfFrozen = 1,
			DamageMultiplierIfFrozen = 1,
			ThawTimeIfFrozen = _G.DEFAULT_THAW_TIME,
			IgnoreIceResistance = false,
			FrozenEnemyDamageMultiplier = 1,
			Description = "TODO",
			Icon = "rbxassetid://78347133405742"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 450,
				HealthIncrease = 35,
				BurstSizeIncrease = 1,
				RangeIncrease = 0.5,
				BodyHeatReductionIncrease = 2,
				Description = "Better Grip",
				Icon = "rbxassetid://124429245241194",
				UpgradeIcon = "rbxassetid://88165890856230"
			},
			{
				Cost = 1350,
				HealthIncrease = 50,
				DamageIncrease = 10,
				SplashMaximumTargetsHitIncrease = 1,
				BodyHeatReductionIncrease = 5,
				ThawTimeIfFrozenIncrease = 0.95,
				PermanentSpeedMultiplierIfFrozenIncrease = -0.1,
				Description = "Speed Reductions",
				Icon = "rbxassetid://139309792938197",
				UpgradeIcon = "rbxassetid://71634067150302"
			},
			{
				Cost = 2325,
				HealthIncrease = 375,
				DamageIncrease = 20,
				ReloadTimeDecrease = 0,
				SplashMaximumTargetsHitIncrease = 1,
				BurstSizeIncrease = 1,
				BodyHeatReductionIncrease = 20,
				FrozenEnemyDamageMultiplierIncrease = 0.15,
				Description = "Crystal Head",
				Icon = "rbxassetid://104548276943061",
				UpgradeIcon = "rbxassetid://109391797928083"
			},
			{
				Cost = 6000,
				HealthIncrease = 650,
				DamageIncrease = 29,
				BodyHeatReductionIncrease = 35,
				StealthDetection = true,
				FrozenEnemyDamageMultiplierIncrease = 0.05,
				Description = "Cryo Fuel",
				Icon = "rbxassetid://117686537894570",
				UpgradeIcon = "rbxassetid://90775213032093"
			},
			{
				Cost = 33000,
				HealthIncrease = 1600,
				ReloadTimeDecrease = 0.5,
				DamageIncrease = 220,
				GainStunImmunity = true,
				RangeIncrease = 1,
				BurstSizeIncrease = 1,
				BodyHeatReductionIncrease = 245,
				FrozenEnemyDamageMultiplierIncrease = 0.2,
				CanFreezeBoss = true,
				DamageDelayOverride = 0.22,
				AbilityNames = { Enums.TowerAbilities.IceBreakerIceShard, Enums.TowerAbilities.IceBreakerSnowStorm },
				Description = "X-Cryo Suit",
				Icon = "rbxassetid://89541513377424",
				UpgradeIcon = "rbxassetid://129440859364636"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Weapon",
	SpecialBurstHandlingForModel = true,
	MaxObstacleHeight = 1.6,
	HasCustomCode = true,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	SetUpKeyframeReachedEventForAttack = true,
	DisallowedBuffTypesMap = {
		[Enums.TowerBuffTypes.Range] = true,
		[Enums.TowerBuffTypes.Range2] = true,
		[Enums.TowerBuffTypes.Range3] = true
	},
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