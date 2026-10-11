local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AttackDisabled = true,
	LimitMap = { 6, 3, 2, 1 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 700,
			Health = 800,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 1,
			Range = 1,
			StealthDetection = false,
			SpawnPathEntityData = {
				{
					PathEntityType = Enums.PathEntities.Humvee0,
					StartDelay = 10,
					Interval = 70,
					MaximumCount = 2
				}
			},
			Description = "BASE",
			Icon = "rbxassetid://16672318125"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 700,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Humvee1,
						StartDelay = 10,
						Interval = 70,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Humvee0 },
				Description = "50 Cal+",
				Icon = "rbxassetid://16672317824",
				UpgradeIcon = "rbxassetid://16672722840"
			},
			{
				Cost = 1200,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Humvee2,
						StartDelay = 10,
						Interval = 70,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Humvee1 },
				Description = "TOW Launcher",
				Icon = "rbxassetid://16672317586",
				UpgradeIcon = "rbxassetid://16672721431"
			},
			{
				Cost = 3000,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Humvee3,
						StartDelay = 10,
						Interval = 70,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Humvee2 },
				Description = "TOW Missile Upgrade",
				Icon = "rbxassetid://16672317122",
				UpgradeIcon = "rbxassetid://16672721189"
			},
			{
				Cost = 8000,
				HealthIncrease = 400,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Humvee4,
						StartDelay = 10,
						Interval = 48,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Humvee3 },
				Description = "Missile Turret",
				Icon = "rbxassetid://16672316599",
				UpgradeIcon = "rbxassetid://16672721869"
			},
			{
				Cost = 38000,
				HealthIncrease = 2500,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.M2Bradley,
						StartDelay = 10,
						Interval = 60,
						MaximumCount = 2
					}
				},
				Description = "M2 Bradley",
				Icon = "rbxassetid://16672315677",
				UpgradeIcon = "rbxassetid://16672722079"
			}
		},
		Path2Data = {
			{
				Cost = 300,
				HealthIncrease = 100,
				ReduceSpawnPathEntityInterval = 6,
				Description = "Vehicle Training",
				Icon = "rbxassetid://16672317824",
				UpgradeIcon = "rbxassetid://16672720970"
			},
			{
				Cost = 400,
				HealthIncrease = 100,
				ReduceSpawnPathEntityInterval = 7,
				Description = "Veteran Training",
				Icon = "rbxassetid://16672317586",
				UpgradeIcon = "rbxassetid://16672720738"
			},
			{
				Cost = 8500,
				HealthIncrease = 250,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.MRAP,
						StartDelay = 10,
						Interval = 72,
						MaximumCount = 2
					}
				},
				Description = "MRAP",
				Icon = "rbxassetid://16672320093",
				UpgradeIcon = "rbxassetid://16672721645"
			},
			{
				Cost = 27000,
				HealthIncrease = 2000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.M1Abrams,
						StartDelay = 10,
						Interval = 90,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = {},
				Description = "M1 Abrams",
				Icon = "rbxassetid://16672319810",
				UpgradeIcon = "rbxassetid://16672722604"
			},
			{
				Cost = 54000,
				HealthIncrease = 3000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.M1XAbrams,
						StartDelay = 10,
						Interval = 60,
						MaximumCount = 2
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.M1Abrams },
				Description = "M1X Abrams",
				Icon = "rbxassetid://16672319498",
				UpgradeIcon = "rbxassetid://16672722294"
			}
		}
	},
	IsMechanical = true,
	DeathEffect = Enums.DeathEffects.GenericExplosionDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoAnimations = true,
	Radius = 3.5,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	BuffEffectScale = 2,
	RangeDisabled = true,
	NoHeal = true,
	OverrideDisplayStats = {},
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 50,
			CostIncreasePerLevel = 25,
			Amount = 0.75
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopHealth,
			Cost = 150,
			CostIncreasePerLevel = 165,
			Amount = 0.7
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopDamage,
			Cost = 175,
			CostIncreasePerLevel = 125,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.TroopRange,
			Cost = 200,
			CostIncreasePerLevel = 125,
			Amount = 0.1
		}
	}
}