local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AttackDisabled = true,
	LimitMap = { 6, 3, 2, 1 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 9000,
			Health = 6250,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 1,
			Range = 1,
			StealthDetection = false,
			SpawnPathEntityData = {
				{
					PathEntityType = Enums.PathEntities.BehemothTank0,
					StartDelay = 10,
					Interval = 150,
					MaximumCount = 1
				}
			},
			Description = "BASE",
			Icon = "rbxassetid://114574970058792"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 6500,
				HealthIncrease = 400,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BehemothTank1,
						StartDelay = 10,
						Interval = 150,
						MaximumCount = 1
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.BehemothTank0 },
				Description = "More Armor",
				Icon = "rbxassetid://133282292910615",
				UpgradeIcon = "rbxassetid://123004925500728"
			},
			{
				Cost = 12000,
				HealthIncrease = 500,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BehemothTank2,
						StartDelay = 10,
						Interval = 150,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.BehemothTank1 },
				Description = "130MM Barrel",
				Icon = "rbxassetid://107934841539398",
				UpgradeIcon = "rbxassetid://87841507893711"
			},
			{
				Cost = 47500,
				HealthIncrease = 4000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BehemothTank3,
						StartDelay = 10,
						Interval = 150,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.BehemothTank2 },
				Description = "Improved Chassis",
				Icon = "rbxassetid://135450371873884",
				UpgradeIcon = "rbxassetid://121604005074948"
			},
			{
				Cost = 150000,
				HealthIncrease = 5000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BehemothTank4,
						StartDelay = 10,
						Interval = 150,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.BehemothTank3 },
				Description = "Dual Barrels",
				Icon = "rbxassetid://125314465730231",
				UpgradeIcon = "rbxassetid://103690529136672"
			},
			{
				Cost = 525000,
				HealthIncrease = 10000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BehemothTank5,
						StartDelay = 10,
						Interval = 150,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.BehemothTank4 },
				Description = "Mammoth",
				Icon = "rbxassetid://136200924007306",
				UpgradeIcon = "rbxassetid://138732564654144"
			}
		},
		Path2Data = {
			{
				Cost = 1850,
				HealthIncrease = 100,
				ReduceSpawnPathEntityInterval = 15,
				Description = "Faster Spawn",
				Icon = "rbxassetid://133282292910615",
				UpgradeIcon = "rbxassetid://89494628584445"
			},
			{
				Cost = 3000,
				HealthIncrease = 100,
				ReduceSpawnPathEntityInterval = 25,
				Description = "Veteran Training",
				Icon = "rbxassetid://107934841539398",
				UpgradeIcon = "rbxassetid://70868503676256"
			},
			{
				Cost = 75000,
				HealthIncrease = 2500,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BehemothTank3B,
						StartDelay = 10,
						Interval = 120,
						MaximumCount = 2
					}
				},
				Description = "Laser Tank",
				Icon = "rbxassetid://134772475175237",
				UpgradeIcon = "rbxassetid://78689184028476"
			},
			{
				Cost = 145000,
				HealthIncrease = 4000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BehemothTank4B,
						StartDelay = 10,
						Interval = 130,
						MaximumCount = 1
					}
				},
				Description = "Chain Reaction",
				Icon = "rbxassetid://88770748085460",
				UpgradeIcon = "rbxassetid://126458990701981"
			},
			{
				Cost = 220000,
				HealthIncrease = 7000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.BehemothTank5B,
						StartDelay = 10,
						Interval = 135,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.BehemothTank4B },
				Description = "X-Laser Tank",
				Icon = "rbxassetid://83438391356676",
				UpgradeIcon = "rbxassetid://79704516537087"
			}
		}
	},
	IsMechanical = true,
	DeathEffect = Enums.DeathEffects.GenericExplosionDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoAnimations = true,
	Radius = 5.5,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	BuffEffectScale = 2,
	RangeDisabled = true,
	NoHeal = true,
	OverrideDisplayStats = {},
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 75,
			CostIncreasePerLevel = 25,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopHealth,
			Cost = 800,
			CostIncreasePerLevel = 625,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopDamage,
			Cost = 750,
			CostIncreasePerLevel = 675,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopRange,
			Cost = 1200,
			CostIncreasePerLevel = 750,
			Amount = 0.1
		}
	}
}