local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 12, 5, 3, 3 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 400,
			Health = 100,
			DamageType = Enums.DamageTypes.Toxic,
			IsSplash = true,
			SplashRadius = 2,
			Damage = 0.5,
			ReloadTime = 4.1,
			Range = 6.7,
			StealthDetection = false,
			BurstSize = 9,
			BurstInterval = 0.333,
			BurstEndTriggerFullReload = true,
			BurstNotInterruptable = true,
			KnockbackStuds = 0.75,
			KnockbackHeight = 2,
			KnockbackSuspendTime = 0,
			KnockbackBuffName = Enums.EnemyBuffs.BubbleBlowerKnockbackDebounce,
			DisableBossKnockback = true,
			DisableMiniBossKnockback = true,
			Description = "",
			Icon = ""
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 285,
				HealthIncrease = 75,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 1,
				SplashRadiusIncrease = 0,
				Description = "GLOVES",
				Icon = "",
				UpgradeIcon = "rbxassetid://102360364981041"
			},
			{
				Cost = 600,
				HealthIncrease = 175,
				DamageIncrease = 0.5,
				OverrideReloadTime = 4,
				RangeIncrease = 2,
				SplashRadiusIncrease = 0,
				KnockbackStudsOverride = 1,
				BurstSizeOverride = 50,
				BurstIntervalOverride = 0.1,
				AimTimeOverride = 43 / 60,
				AimResetTimeOverride = 2.866,
				Description = "BUBBLE GUN",
				Icon = "",
				UpgradeIcon = "rbxassetid://73185855817361"
			},
			{
				Cost = 2150,
				HealthIncrease = 265,
				DamageIncrease = 0.5,
				OverrideReloadTime = 4,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0,
				KnockbackStudsOverride = 1.5,
				BurstSizeOverride = 50,
				BurstIntervalOverride = 0.1,
				AimTimeOverride = 43 / 60,
				AimResetTimeOverride = 2.866,
				Description = "BIG MUSCLES",
				Icon = "",
				UpgradeIcon = "rbxassetid://89289592341234"
			},
			{
				Cost = 4750,
				HealthIncrease = 500,
				DamageIncrease = 0,
				OverrideReloadTime = 4,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0,
				KnockbackStudsOverride = 1.6,
				BurstSizeOverride = 120,
				BurstIntervalOverride = 0.1,
				AimTimeOverride = 43 / 60,
				AimResetTimeOverride = 2.866,
				Description = "EXTRA BUBBLES",
				Icon = "",
				UpgradeIcon = "rbxassetid://117804075111781"
			},
			{
				Cost = 17250,
				HealthIncrease = 1250,
				DamageIncrease = 0,
				OverrideReloadTime = 0.14,
				RemoveBurst = true,
				RangeIncrease = 7,
				SplashRadiusIncrease = 0,
				ReplicateReloadingOverride = false,
				AimTimeOverride = 41 / 60,
				AimResetTimeOverride = 50 / 60,
				KnockbackBuffNameOverride = Enums.EnemyBuffs.BubbleBlowerKnockbackDebounceLevel5,
				KnockbackRiseTimeOverride = 1,
				KnockbackStudsOverride = 0,
				KnockbackSuspendTimeOverride = 2.25,
				KnockbackSuspendEffectNameOverride = Enums.VisualEffects.BubbleSuspend,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BubbleCompanion,
						StartDelay = 1,
						Interval = 15,
						MaximumCount = 3,
						SpawnNearParentTower = true
					}
				},
				Description = "SUPER BUBBLE MAN",
				Icon = "",
				UpgradeIcon = "rbxassetid://117673039132463"
			}
		}
	},
	ReplicateReloading = true,
	NoRestartAttackAnimationIfPlaying = true,
	CanPlayAttackAnimationAgain = true,
	AdditionalDisplayStats = { "KnockbackStuds", "KnockbackSuspendTime" },
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 1000,
			CostIncreasePerLevel = 25,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 1000,
			CostIncreasePerLevel = 125,
			Amount = 1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 1000,
			CostIncreasePerLevel = 50,
			Amount = 0.15
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://116646263240356"
}