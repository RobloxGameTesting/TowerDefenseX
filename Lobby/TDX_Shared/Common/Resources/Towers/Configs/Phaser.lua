local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 9, 5, 4, 3 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 22500,
			Health = 1200,
			DamageType = Enums.DamageTypes.Laser,
			Damage = 30,
			ReloadTime = 0.2,
			Range = 25,
			StealthDetection = false,
			AimTime = 1.333,
			AimResetTime = 1.333,
			DamageIncreasePerSecond = 1,
			LockOnTarget = true,
			RetargetCooldown = 2.5,
			Description = "",
			Icon = ""
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 5000,
				HealthIncrease = 350,
				DamageIncrease = 7.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				DamageIncreasePerSecondOverride = 2.5,
				Description = "Focused Lens",
				Icon = "",
				UpgradeIcon = "rbxassetid://91559948550918"
			},
			{
				Cost = 14500,
				HealthIncrease = 1050,
				DamageIncrease = 12.5,
				ReloadTimeDecrease = 0,
				DamageIncreasePerSecondOverride = 8,
				Description = "Amplified Output",
				Icon = "",
				UpgradeIcon = "rbxassetid://99759509058095"
			},
			{
				Cost = 50000,
				HealthIncrease = 4250,
				DamageIncrease = 60,
				ReloadTimeDecrease = 0,
				RangeIncrease = 13,
				GainStealthDetection = true,
				GainIgnoreObstacles = true,
				DamageIncreasePerSecondOverride = 15,
				Description = "Phase Accelerator",
				Icon = "",
				UpgradeIcon = "rbxassetid://140559821392354"
			},
			{
				Cost = 585000,
				HealthIncrease = 8500,
				DamageIncrease = 174,
				ReloadTimeDecrease = 0,
				DamageIncreasePerSecondOverride = 65,
				Description = "Overcharged Core",
				Icon = "",
				UpgradeIcon = "rbxassetid://102614984980250"
			},
			{
				Cost = 1000000,
				HealthIncrease = 10000,
				DamageIncrease = 230,
				ReloadTimeDecrease = 0,
				RangeIncrease = 10,
				DamageIncreasePerSecondOverride = 160,
				Description = "Phase Annihilator",
				Icon = "",
				UpgradeIcon = "rbxassetid://103698383299289"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoRestartAttackAnimationIfPlaying = true,
	CanPlayAttackAnimationAgain = true,
	CustomQueryOptions = { "First" },
	GunModelName = "Gun",
	GunModelSoundGroupName = "FireLoop",
	GunModelSoundGroupStopDelay = 0.3,
	GunModelSoundGroupStopDelayBufferForTowers = 0.1,
	DamageMultiplierScalesEffects = true,
	MaxObstacleHeight = 1.6,
	Radius = 2,
	HoverHeight = 1.21,
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
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 250,
			CostIncreasePerLevel = 125,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 400,
			CostIncreasePerLevel = 300,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.15
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://99368406318847"
}