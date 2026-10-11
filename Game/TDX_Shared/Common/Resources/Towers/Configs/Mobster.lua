local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Mobster = {
	LimitMap = { 9, 5, 4, 3 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 400,
			Health = 100,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 4,
			ReloadTime = 0.9,
			Range = 9.5,
			StealthDetection = false,
			BurstSize = 1,
			BurstInterval = 0.35,
			NearbyTowerDeathCashback = 0,
			Description = "",
			Icon = "rbxassetid://71632736224343"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 200,
				HealthIncrease = 25,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				Description = "+P Ammo",
				Icon = "rbxassetid://106992366419808",
				UpgradeIcon = "rbxassetid://15247048937"
			},
			{
				Cost = 1000,
				HealthIncrease = 50,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Goon1,
						StartDelay = 5,
						Interval = 55,
						MaximumCount = 3
					}
				},
				Description = "The Mob",
				Icon = "rbxassetid://106200462915277",
				UpgradeIcon = "rbxassetid://103060908765375"
			},
			{
				Cost = 4000,
				HealthIncrease = 200,
				DamageIncrease = -2,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 0,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Goon1,
						StartDelay = 5,
						Interval = 48,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 4
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Goon1 },
				Description = "MAC 10",
				Icon = "rbxassetid://126011461987434",
				UpgradeIcon = "rbxassetid://119172095953719"
			},
			{
				Cost = 7000,
				HealthIncrease = 450,
				DamageIncrease = 5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Goon2,
						StartDelay = 5,
						Interval = 48,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 4
					}
				},
				AbilityNames = { Enums.TowerAbilities.MobsterGainIgnoreResistance },
				Description = "Upgraded Henchmen",
				Icon = "rbxassetid://112753810542357",
				UpgradeIcon = "rbxassetid://85015211429767"
			},
			{
				Cost = 18680,
				HealthIncrease = 800,
				DamageIncrease = 26,
				ReloadTimeDecrease = 0,
				RangeIncrease = 4,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Goon3,
						StartDelay = 5,
						Interval = 43,
						BurstSize = 3,
						BurstInterval = 1,
						MaximumCount = 4
					}
				},
				AbilityNames = { Enums.TowerAbilities.MobsterGainIgnoreResistance },
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Goon1 },
				Description = "Mafia Army",
				Icon = "rbxassetid://84838953486432",
				UpgradeIcon = "rbxassetid://119551275459799"
			}
		},
		Path2Data = {
			{
				Cost = 150,
				HealthIncrease = 25,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				Description = "Extended Barrel",
				Icon = "rbxassetid://106992366419808",
				UpgradeIcon = "rbxassetid://112491775459339"
			},
			{
				Cost = 225,
				HealthIncrease = 25,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.25,
				GainStealthDetection = true,
				RangeIncrease = 0,
				Description = "Advanced Visors",
				Icon = "rbxassetid://106200462915277",
				UpgradeIcon = "rbxassetid://122886730860778"
			},
			{
				Cost = 5000,
				HealthIncrease = 150,
				DamageIncrease = 22,
				ReloadTimeDecrease = -0.2,
				RangeIncrease = 5,
				DisplayCashEarned = true,
				AbilityNames = { Enums.TowerAbilities.MobsterBounty1 },
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Agent1,
						StartDelay = 5,
						Interval = 62,
						MaximumCount = 1
					}
				},
				NearbyTowerDeathCashbackIncrease = 0.05,
				GainPlacementDisplayDashedRange = true,
				Description = "Bounty Hunter",
				Icon = "rbxassetid://121290782227893",
				UpgradeIcon = "rbxassetid://128924382621739"
			},
			{
				Cost = 8500,
				HealthIncrease = 700,
				DamageIncrease = 32,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				AbilityNames = { Enums.TowerAbilities.MobsterBounty2 },
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Agent2,
						StartDelay = 5,
						Interval = 62,
						BurstInterval = 1,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Agent1 },
				NearbyTowerDeathCashbackIncrease = 0.05,
				Description = "Life Insurance",
				Icon = "rbxassetid://77827711661719",
				UpgradeIcon = "rbxassetid://83055676437433"
			},
			{
				Cost = 45000,
				HealthIncrease = 1300,
				DamageIncrease = 120,
				ReloadTimeDecrease = -0.1,
				GainIgnoreResistance = true,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.MobsterBounty3 },
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Agent3,
						StartDelay = 5,
						Interval = 62,
						BurstInterval = 1,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Agent2 },
				NearbyTowerDeathCashbackIncrease = 0.1,
				Description = "Mafia Boss",
				Icon = "rbxassetid://70656998334432",
				UpgradeIcon = "rbxassetid://104187530835331"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
}
Mobster.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 50,
		CostIncreasePerLevel = 50,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 175,
		CostIncreasePerLevel = 75,
		Amount = 0.75
	},
	{ Type = Enums.TowerUpgradeShopTypes.Range, Cost = 75, CostIncreasePerLevel = 15, Amount = 0.1 },
	{
		Type = Enums.TowerUpgradeShopTypes.TroopHealth,
		Cost = 200,
		CostIncreasePerLevel = 100,
		Amount = 0.5
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopDamage,
		Cost = 200,
		CostIncreasePerLevel = 100,
		Amount = 0.3
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopRange,
		Cost = 200,
		CostIncreasePerLevel = 100,
		Amount = 0.15
	},
	{
		Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
		Cost = 50,
		CostIncreasePerLevel = 5,
		Amount = 0.15
	}
}
return Mobster