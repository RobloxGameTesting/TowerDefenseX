local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 5, 3, 3, 2 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 1350,
			Health = 300,
			DamageType = Enums.DamageTypes.Golden,
			Damage = 9,
			Range = 15,
			StealthDetection = false,
			BurstSize = 6,
			CashPerCompletedBurst = 0,
			BurstInterval = 0.4,
			BurstEndTriggerFullReload = true,
			ReloadTime = 2.5,
			NearbyTowerDeathCashback = 0,
			Description = "",
			Icon = "rbxassetid://99575787122937"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 850,
				HealthIncrease = 100,
				DamageIncrease = 8,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Additional Ammo",
				Icon = "rbxassetid://86516243841062",
				UpgradeIcon = "rbxassetid://84892583353155"
			},
			{
				Cost = 2000,
				HealthIncrease = 200,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0.2,
				RangeIncrease = 0,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Enforcer1,
						StartDelay = 5,
						Interval = 55,
						MaximumCount = 3
					}
				},
				Description = "Golden Troop",
				Icon = "rbxassetid://110902013605511",
				UpgradeIcon = "rbxassetid://101427721363085"
			},
			{
				Cost = 11500,
				HealthIncrease = 550,
				DamageIncrease = 9,
				BurstSizeIncrease = 10,
				BurstIntervalOverride = 0.13,
				CashPerCompletedBurstIncrease = 200,
				DisplayCashEarned = true,
				ReloadTimeDecrease = 0.22,
				RangeIncrease = 0,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Enforcer1,
						StartDelay = 5,
						Interval = 48,
						BurstSize = 3,
						BurstInterval = 1,
						MaximumCount = 6
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Enforcer1 },
				Description = "Golden Squad",
				Icon = "rbxassetid://106370214252756",
				UpgradeIcon = "rbxassetid://98071923001299"
			},
			{
				Cost = 30000,
				HealthIncrease = 1000,
				DamageIncrease = 18,
				ReloadTimeDecrease = 0,
				CashPerCompletedBurstIncrease = 850,
				BurstSizeIncrease = 16,
				BurstIntervalOverride = 0.2,
				RangeIncrease = 1,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Enforcer2,
						StartDelay = 5,
						Interval = 48,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 4
					}
				},
				AbilityNames = { Enums.TowerAbilities.GoldenMobsterGainIgnoreResistance },
				Description = "Golden Army",
				Icon = "rbxassetid://114243369419863",
				UpgradeIcon = "rbxassetid://106083384711455"
			},
			{
				Cost = 125000,
				HealthIncrease = 1875,
				DamageIncrease = 32,
				BurstIntervalOverride = 0.13,
				CashPerCompletedBurstIncrease = 1700,
				BurstSizeIncrease = 32,
				ReloadTimeDecrease = -0.17,
				RangeIncrease = 4,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Enforcer3,
						StartDelay = 5,
						Interval = 40,
						BurstSize = 4,
						BurstInterval = 1,
						MaximumCount = 12
					}
				},
				AbilityNames = { Enums.TowerAbilities.GoldenMobsterGainIgnoreResistance },
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Enforcer1 },
				Description = "Golden Mafia",
				Icon = "rbxassetid://75612878943105",
				UpgradeIcon = "rbxassetid://71881941148085"
			}
		},
		Path2Data = {
			{
				Cost = 275,
				HealthIncrease = 25,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 5,
				GainStealthDetection = true,
				Description = "Upgraded Visor",
				Icon = "rbxassetid://86516243841062",
				UpgradeIcon = "rbxassetid://73917608069720"
			},
			{
				Cost = 333,
				HealthIncrease = 75,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.5,
				CashPerCompletedBurstIncrease = 0,
				RangeIncrease = 0,
				Description = "Regenerative Reload",
				Icon = "rbxassetid://110902013605511",
				UpgradeIcon = "rbxassetid://86034137765333"
			},
			{
				Cost = 17000,
				HealthIncrease = 1000,
				DamageIncrease = 57,
				GainCanTargetAir = true,
				ReloadTimeDecrease = -0.6,
				RangeIncrease = 4,
				CashPerCompletedBurstIncrease = 0,
				BurstIntervalOverride = 0.5,
				DisplayCashEarned = true,
				AbilityNames = { Enums.TowerAbilities.GoldenMobsterBounty1 },
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Enforcer1,
						StartDelay = 5,
						Interval = 30,
						MaximumCount = 3
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Enforcer1 },
				NearbyTowerDeathCashbackIncrease = 0.2,
				GainPlacementDisplayDashedRange = true,
				Description = "Bounty Seeker",
				Icon = "rbxassetid://111392374823178",
				UpgradeIcon = "rbxassetid://73881195395410"
			},
			{
				Cost = 36000,
				HealthIncrease = 1500,
				DamageIncrease = 50,
				CashPerCompletedBurstIncrease = 0,
				BurstIntervalOverride = 0.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.GoldenMobsterBounty2 },
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Reaper1,
						StartDelay = 5,
						Interval = 62,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Reaper1 },
				NearbyTowerDeathCashbackIncrease = 0.05,
				Description = "Golden Sniper",
				Icon = "rbxassetid://75585047488855",
				UpgradeIcon = "rbxassetid://117057632743227"
			},
			{
				Cost = 140000,
				HealthIncrease = 3800,
				CashPerCompletedBurstIncrease = 0,
				BurstIntervalOverride = 0.66,
				DamageIncrease = 300,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.GoldenMobsterBounty3 },
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Reaper2,
						StartDelay = 5,
						Interval = 62,
						BurstInterval = 1,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Reaper1 },
				NearbyTowerDeathCashbackIncrease = 0.1,
				Description = "Gold Economy",
				Icon = "rbxassetid://76031295806045",
				UpgradeIcon = "rbxassetid://134474587551439"
			}
		}
	},
	ReplicateReloading = true,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	SetUpKeyframeReachedEventForAttack = true,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	HoverHeight = 1.317,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, -3.141592653589793, 0),
	PlacementEffectName = Enums.VisualEffects.GoldenPlacement,
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 50,
			CostIncreasePerLevel = 50,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 175,
			CostIncreasePerLevel = 350,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 75,
			CostIncreasePerLevel = 15,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopHealth,
			Cost = 100,
			CostIncreasePerLevel = 100,
			Amount = 0.8
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopDamage,
			Cost = 100,
			CostIncreasePerLevel = 200,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopRange,
			Cost = 50,
			CostIncreasePerLevel = 300,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.CashPerFullReload,
			Cost = 200,
			CostIncreasePerLevel = 775,
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