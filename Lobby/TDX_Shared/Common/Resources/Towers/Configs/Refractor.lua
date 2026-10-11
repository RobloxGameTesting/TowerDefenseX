local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 13, 8, 6, 5 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 20000,
			Health = 1800,
			DamageType = Enums.DamageTypes.Golden,
			Damage = 40,
			ReloadTime = 0.2,
			Range = 24,
			StealthDetection = false,
			AimTime = 1.333,
			AimResetTime = 1.333,
			Description = "",
			Icon = "rbxassetid://124176128931756"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 8750,
				HealthIncrease = 250,
				DamageIncrease = 9,
				ReloadTimeDecrease = 0,
				RangeIncrease = 5,
				Description = "Cell Refusion",
				Icon = "rbxassetid://94449246633330",
				UpgradeIcon = "rbxassetid://107636246219439"
			},
			{
				Cost = 17500,
				HealthIncrease = 450,
				DamageIncrease = 12,
				ReloadTimeDecrease = 0.05,
				RangeIncrease = 2,
				Description = "Fusion Core",
				Icon = "rbxassetid://139333120235286",
				UpgradeIcon = "rbxassetid://96991065627910"
			},
			{
				Cost = 43500,
				HealthIncrease = 2750,
				DamageIncrease = 15,
				GainStealthDetection = true,
				GainIgnoreObstacles = true,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				ChainCountIncrease = 1,
				ChainMaxDistanceIncrease = 7,
				ChainDamageMultiplierIncrease = 0.5,
				Description = "Beam Spreader",
				Icon = "rbxassetid://87652529239555",
				UpgradeIcon = "rbxassetid://130016086134525"
			},
			{
				Cost = 110000,
				HealthIncrease = 4000,
				DamageIncrease = 60,
				ReloadTimeDecrease = 0,
				GainStunImmunity = true,
				RangeIncrease = 0,
				ChainCountIncrease = 2,
				ChainMaxDistanceIncrease = 1,
				ChainDamageMultiplierIncrease = 0.1,
				Description = "Chain Reaction",
				Icon = "rbxassetid://115274706401975",
				UpgradeIcon = "rbxassetid://102892476417804"
			},
			{
				Cost = 225000,
				HealthIncrease = 12000,
				DamageIncrease = 137,
				ReloadTimeDecrease = 0,
				RangeIncrease = 13,
				ChainCountIncrease = 4,
				ChainMaxDistanceIncrease = 1,
				ChainDamageMultiplierIncrease = 0.4,
				Description = "Atom Defuser",
				Icon = "rbxassetid://117809781232316",
				UpgradeIcon = "rbxassetid://76663362575944"
			}
		},
		Path2Data = {
			{
				Cost = 7000,
				HealthIncrease = 150,
				DamageIncrease = 10,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Damage Increase",
				Icon = "rbxassetid://94449246633330",
				UpgradeIcon = "rbxassetid://115500605092581"
			},
			{
				Cost = 19000,
				HealthIncrease = 300,
				DamageIncrease = 17,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Damage Multiplier",
				Icon = "rbxassetid://139333120235286",
				UpgradeIcon = "rbxassetid://120945166005243"
			},
			{
				Cost = 55000,
				HealthIncrease = 3250,
				DamageIncrease = 50,
				ReloadTimeDecrease = 0,
				RangeIncrease = 8,
				DamageIncreaseOverTimeMaxMultiplierOverride = 1.8,
				DamageIncreaseOverTimeDurationOverride = 15,
				DamageIncreaseOverTimeCooldownOverride = 8.5,
				GainStunImmunity = true,
				Description = "Destructor Beam",
				Icon = "rbxassetid://137686999785985",
				UpgradeIcon = "rbxassetid://75969369617470"
			},
			{
				Cost = 225000,
				HealthIncrease = 6750,
				GainStealthDetection = true,
				DamageIncrease = 125,
				ReloadTimeDecrease = 0,
				RangeIncrease = 10,
				DamageIncreaseOverTimeMaxMultiplierOverride = 2.4,
				DamageIncreaseOverTimeDurationOverride = 17,
				DamageIncreaseOverTimeCooldownOverride = 8,
				Description = "Core Fusion",
				Icon = "rbxassetid://128584176260297",
				UpgradeIcon = "rbxassetid://102157281657351"
			},
			{
				Cost = 1000000,
				HealthIncrease = 15000,
				DynamicPriceScaling = 8000,
				DamageIncrease = 450,
				ReloadTimeDecrease = 0,
				RangeIncrease = 8,
				DamageIncreaseOverTimeMaxMultiplierOverride = 3.5,
				DamageIncreaseOverTimeDurationOverride = 19,
				DamageIncreaseOverTimeCooldownOverride = 22,
				Description = "Calamity Beam",
				Icon = "rbxassetid://80817231746003",
				UpgradeIcon = "rbxassetid://81010434687199"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoRestartAttackAnimationIfPlaying = true,
	CanPlayAttackAnimationAgain = true,
	GunModelName = "Gun",
	GunModelSoundGroupName = "FireLoop",
	GunModelSoundGroupStopDelay = 0.3,
	GunModelSoundGroupStopDelayBufferForTowers = 0.1,
	DamageMultiplierScalesEffects = true,
	MaxObstacleHeight = 1.6,
	Radius = 2.4,
	HoverHeight = 1.57,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DisallowedBuffTypesMap = {
		[Enums.TowerBuffTypes.Damage] = true,
		[Enums.TowerBuffTypes.Damage2] = true,
		[Enums.TowerBuffTypes.Damage3] = true
	},
	BeamEffectForDefaultAttack = true,
	DefaultBeamEffectHandlingData = {
		{
			BeamParentInstancePath = { "BeamEffects", "Beam" },
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		}
	},
	AdditionalDisplayStats = { "IgnoreObstacles" },
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 400,
			CostIncreasePerLevel = 185,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 775,
			CostIncreasePerLevel = 650,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.ChainDamage,
			Cost = 300,
			CostIncreasePerLevel = 150,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 285,
			CostIncreasePerLevel = 150,
			Amount = 0.15
		}
	}
}