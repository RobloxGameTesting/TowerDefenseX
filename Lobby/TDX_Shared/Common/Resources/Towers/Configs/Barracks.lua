local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AttackDisabled = true,
	LimitMap = { 7, 6, 5, 4 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 325,
			Health = 500,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 1,
			Range = 1,
			StealthDetection = false,
			SpawnPathEntityData = {
				{
					PathEntityType = Enums.PathEntities.Scout0,
					StartDelay = 10,
					Interval = 55,
					MaximumCount = 3
				}
			},
			Description = "BASE",
			Icon = "rbxassetid://15502980243"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 300,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Scout1,
						StartDelay = 10,
						Interval = 55,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 3
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Scout0 },
				Description = "Scout",
				Icon = "rbxassetid://15502980176",
				UpgradeIcon = "rbxassetid://15511066043"
			},
			{
				Cost = 700,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Scout2,
						StartDelay = 10,
						Interval = 55,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 3
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Scout1 },
				Description = "Riflemen",
				Icon = "rbxassetid://15502980100",
				UpgradeIcon = "rbxassetid://15511066226"
			},
			{
				Cost = 1600,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Scout3,
						StartDelay = 10,
						Interval = 55,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 3
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Scout2 },
				Description = "Assault Class",
				Icon = "rbxassetid://15502979980",
				UpgradeIcon = "rbxassetid://15511066536"
			},
			{
				Cost = 3800,
				HealthIncrease = 400,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Scout4,
						StartDelay = 10,
						Interval = 55,
						BurstSize = 3,
						BurstInterval = 1,
						MaximumCount = 3
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Scout3 },
				Description = "Spec Ops",
				Icon = "rbxassetid://15502979770",
				UpgradeIcon = "rbxassetid://15511065918"
			},
			{
				Cost = 30000,
				HealthIncrease = 800,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.RailTrooper,
						StartDelay = 10,
						Interval = 60,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 3
					}
				},
				Description = "Rail Trooper",
				Icon = "rbxassetid://15502979637",
				UpgradeIcon = "rbxassetid://15511066289"
			}
		},
		Path2Data = {
			{
				Cost = 125,
				HealthIncrease = 100,
				ReduceSpawnPathEntityInterval = 6,
				Description = "Troop Training",
				Icon = "rbxassetid://15502980176",
				UpgradeIcon = "rbxassetid://15511065813"
			},
			{
				Cost = 250,
				HealthIncrease = 100,
				ReduceSpawnPathEntityInterval = 7,
				Description = "Veteran Training",
				Icon = "rbxassetid://15502980100",
				UpgradeIcon = "rbxassetid://15511065617"
			},
			{
				Cost = 3850,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.M202Trooper,
						StartDelay = 10,
						Interval = 72,
						MaximumCount = 3
					}
				},
				Description = "M202 Trooper",
				Icon = "rbxassetid://15502980048",
				UpgradeIcon = "rbxassetid://15511066378"
			},
			{
				Cost = 5250,
				HealthIncrease = 400,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Rioter,
						StartDelay = 10,
						Interval = 25,
						MaximumCount = 3
					}
				},
				Description = "Rioter",
				Icon = "rbxassetid://15502979877",
				UpgradeIcon = "rbxassetid://15511066128"
			},
			{
				Cost = 12000,
				HealthIncrease = 400,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Flamethrower,
						StartDelay = 10,
						Interval = 60,
						MaximumCount = 3
					}
				},
				Description = "Flamethrower",
				Icon = "rbxassetid://15502979705",
				UpgradeIcon = "rbxassetid://15511066453"
			}
		}
	},
	IsMechanical = true,
	DeathEffect = Enums.DeathEffects.GenericExplosionDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoAnimations = true,
	Radius = 3,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BuffEffectScale = 2,
	RangeDisabled = true,
	NoHeal = true,
	OverrideDisplayStats = {},
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 50,
			CostIncreasePerLevel = 25,
			Amount = 2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopHealth,
			Cost = 100,
			CostIncreasePerLevel = 75,
			Amount = 1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopDamage,
			Cost = 200,
			CostIncreasePerLevel = 150,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopRange,
			Cost = 250,
			CostIncreasePerLevel = 250,
			Amount = 0.2
		}
	}
}