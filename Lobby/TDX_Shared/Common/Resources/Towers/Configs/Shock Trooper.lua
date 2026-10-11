local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 3, 2, 1, 1 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 550,
			Health = 300,
			DamageType = Enums.DamageTypes.Lightning,
			Damage = 10,
			ReloadTime = 3,
			Range = 15,
			StunType = Enums.StunTypes.ShockTrooperStun,
			StunDuration = 0.3,
			StealthDetection = true,
			ChainCount = 1,
			ChainMaxDistance = 4,
			ChainDamageMultiplier = 0.5,
			Description = "",
			Icon = "rbxassetid://80793023553405"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 500,
				HealthIncrease = 50,
				ReloadTimeDecrease = 1.5,
				StunDurationIncrease = 0,
				Description = "Faster Charge",
				Icon = "rbxassetid://95319361287016",
				UpgradeIcon = "rbxassetid://124922126260202"
			},
			{
				Cost = 1200,
				HealthIncrease = 100,
				DamageIncrease = 14,
				RangeIncrease = 2,
				ChainCountIncrease = 1,
				ChainMaxDistanceIncrease = 1,
				Description = "EXTRA Voltage",
				Icon = "rbxassetid://70797350321873",
				UpgradeIcon = "rbxassetid://79497418772624"
			},
			{
				Cost = 5500,
				HealthIncrease = 575,
				DamageIncrease = 28,
				GainCanTargetAir = true,
				GainIgnoreObstacles = true,
				ReloadTimeDecrease = -0.5,
				RangeIncrease = 5,
				StunDurationIncrease = 0.2,
				ChainCountIncrease = 1,
				ChainMaxDistanceIncrease = 5,
				ChainDamageMultiplierIncrease = 0.1,
				DamageDelayOverride = 0.25,
				Description = "Tesla Tower",
				Icon = "rbxassetid://84036868856240",
				UpgradeIcon = "rbxassetid://79976582174951"
			},
			{
				Cost = 18000,
				HealthIncrease = 1500,
				DamageIncrease = 60,
				ReloadTimeDecrease = -0.25,
				RangeIncrease = 5,
				StunDurationIncrease = 0.1,
				ChainCountIncrease = 1,
				ChainMaxDistanceIncrease = 4,
				ChainDamageMultiplierIncrease = 0.1,
				DamageDelayOverride = 0.25,
				Description = "Solar Radar",
				Icon = "rbxassetid://116213658321278",
				UpgradeIcon = "rbxassetid://72568658403000"
			},
			{
				Cost = 75000,
				HealthIncrease = 1500,
				DamageIncrease = 440,
				ReloadTimeDecrease = -1.8,
				RangeIncrease = 7,
				StunDurationIncrease = 0.3,
				ChainCountIncrease = 7,
				ChainMaxDistanceIncrease = 6,
				ChainDamageMultiplierIncrease = 0.55,
				DamageDelayOverride = 0.25,
				Description = "MAXIMUM Charge",
				Icon = "rbxassetid://92750324829695",
				UpgradeIcon = "rbxassetid://118451674701817"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 2.8,
	HoverHeight = 1.416,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BeamEffectForDefaultAttack = true,
	BeamEffectDuration = 0.3,
	DefaultBeamEffectHandlingData = {
		{
			BeamParentInstancePath = { "BeamEffects", "Beam" },
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		}
	},
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 125,
			CostIncreasePerLevel = 35,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 750,
			CostIncreasePerLevel = 1500,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.ChainDamage,
			Cost = 625,
			CostIncreasePerLevel = 1000,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Firerate,
			Cost = 325,
			CostIncreasePerLevel = 800,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 175,
			CostIncreasePerLevel = 175,
			Amount = 0.15
		}
	}
}