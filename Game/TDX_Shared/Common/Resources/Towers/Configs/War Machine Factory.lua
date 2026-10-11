local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WarMachineFactory = {
	AttackDisabled = true,
	LimitMap = { 5, 2, 1, 1 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 21000,
			Health = 30000,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 1,
			Range = 1,
			StealthDetection = false,
			SpawnPathEntityData = {
				{
					PathEntityType = Enums.PathEntities.WarMachine0,
					StartDelay = 12,
					Interval = 235,
					BurstSize = 2,
					BurstInterval = 5,
					MaximumCount = 2
				}
			},
			Description = "",
			Icon = "rbxassetid://125632883611829"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 8000,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.WarMachine1,
						StartDelay = 10,
						Interval = 235,
						BurstSize = 2,
						BurstInterval = 5,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.WarMachine0 },
				Description = "Uranium Armor",
				Icon = "rbxassetid://100866628689591",
				UpgradeIcon = "rbxassetid://96074501868150"
			},
			{
				Cost = 18500,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.WarMachine2,
						StartDelay = 12,
						Interval = 235,
						BurstSize = 2,
						BurstInterval = 5,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.WarMachine1 },
				Description = "Dual Cannons",
				Icon = "rbxassetid://123915445832443",
				UpgradeIcon = "rbxassetid://120021114065319"
			},
			{
				Cost = 38500,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.WarMachine3_X,
						StartDelay = 12,
						BurstSize = 2,
						BurstInterval = 5,
						Interval = 235,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.WarMachine2 },
				Description = "Minigun Arm",
				Icon = "rbxassetid://140624644626172",
				UpgradeIcon = "rbxassetid://87422167229047"
			},
			{
				Cost = 78500,
				HealthIncrease = 400,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.WarMachine4_X,
						StartDelay = 12,
						Interval = 235,
						BurstSize = 2,
						BurstInterval = 5,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.WarMachine3_X },
				Description = "Dual Weapons",
				Icon = "rbxassetid://104485374659260",
				UpgradeIcon = "rbxassetid://134680556026649"
			},
			{
				Cost = 175000,
				HealthIncrease = 5000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.WarMachine5_X,
						StartDelay = 12,
						Interval = 140,
						BurstSize = 2,
						BurstInterval = 5,
						MaximumCount = 4
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.WarMachine4_X },
				Description = "Quad Miniguns",
				Icon = "rbxassetid://101399675989657",
				UpgradeIcon = "rbxassetid://109083602730786"
			}
		},
		Path2Data = {
			{
				Cost = 2500,
				HealthIncrease = 100,
				ReduceSpawnPathEntityInterval = 20,
				Description = "Mecha Upgrades",
				Icon = "rbxassetid://100866628689591",
				UpgradeIcon = "rbxassetid://110447086208309"
			},
			{
				Cost = 3000,
				HealthIncrease = 100,
				ReduceSpawnPathEntityInterval = 24,
				Description = "Veteran Training",
				Icon = "rbxassetid://123915445832443",
				UpgradeIcon = "rbxassetid://79382966486811"
			},
			{
				Cost = 150000,
				HealthIncrease = 250,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.WarMachineX_3,
						StartDelay = 10,
						Interval = 260,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = {
					Enums.PathEntities.WarMachine0,
					Enums.PathEntities.WarMachine1,
					Enums.PathEntities.WarMachine2
				},
				Description = "War Machine I",
				Icon = "rbxassetid://115645399231860",
				UpgradeIcon = "rbxassetid://90203013003280"
			},
			{
				Cost = 200000,
				HealthIncrease = 2000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.WarMachineX_4,
						StartDelay = 10,
						Interval = 275,
						MaximumCount = 1
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.WarMachineX_3 },
				Description = "War Machine II",
				Icon = "rbxassetid://97931548342492",
				UpgradeIcon = "rbxassetid://75137435534604"
			},
			{
				Cost = 1100000,
				HealthIncrease = 10000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.WarMachineX_5,
						StartDelay = 10,
						Interval = 280,
						MaximumCount = 1
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.WarMachineX_4 },
				Description = "War Machine III",
				Icon = "rbxassetid://111296953144582",
				UpgradeIcon = "rbxassetid://111171644372837"
			}
		}
	},
	IsMechanical = true,
	DeathEffect = Enums.DeathEffects.GenericExplosionDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoAnimations = true,
	Radius = 6.5,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	BuffEffectScale = 2,
	RangeDisabled = true,
	NoBuffs = true,
	NoHeal = true,
	OverrideDisplayStats = {}
}
WarMachineFactory.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 150,
		CostIncreasePerLevel = 25,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopHealth,
		Cost = 700,
		CostIncreasePerLevel = 500,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopDamage,
		Cost = 800,
		CostIncreasePerLevel = 700,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopRange,
		Cost = 1500,
		CostIncreasePerLevel = 500,
		Amount = 0.1
	}
}
return WarMachineFactory