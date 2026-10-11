local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Zed = {
	AttackDisabled = true,
	LimitMap = { 6, 4, 3, 2 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 5650,
			Health = 850,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 0.7,
			Range = 1,
			StealthDetection = false,
			SpawnPathEntityData = {
				{
					PathEntityType = Enums.PathEntities.Zed0,
					StartDelay = 10,
					Interval = 70,
					MaximumCount = 1
				}
			},
			Description = "BASE",
			Icon = "rbxassetid://18406776917"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 3700,
				HealthIncrease = 400,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Zed1,
						StartDelay = 10,
						Interval = 60,
						MaximumCount = 1
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Zed0 },
				Description = "Spiked Tracks",
				Icon = "rbxassetid://18406776657",
				UpgradeIcon = "rbxassetid://18462180345"
			},
			{
				Cost = 4400,
				HealthIncrease = 800,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Zed2,
						StartDelay = 10,
						Interval = 60,
						MaximumCount = 1
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Zed1 },
				Description = "Arm Cannon",
				Icon = "rbxassetid://18406776421",
				UpgradeIcon = "rbxassetid://18462180345"
			},
			{
				Cost = 25000,
				HealthIncrease = 1400,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Zed3,
						StartDelay = 10,
						Interval = 60,
						MaximumCount = 1
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Zed2 },
				Description = "Mecha",
				Icon = "rbxassetid://18406776205",
				UpgradeIcon = "rbxassetid://18462180345"
			},
			{
				Cost = 85000,
				HealthIncrease = 3000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Zed4,
						StartDelay = 10,
						Interval = 60,
						MaximumCount = 1
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Zed3 },
				Description = "Super Mecha",
				Icon = "rbxassetid://18406775985",
				UpgradeIcon = "rbxassetid://18462180345"
			},
			{
				Cost = 290000,
				HealthIncrease = 6000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Zed5,
						StartDelay = 10,
						Interval = 60,
						MaximumCount = 1
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Zed4 },
				Description = "Eradication",
				Icon = "rbxassetid://18406775780",
				UpgradeIcon = "rbxassetid://18462180189"
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
	BannedInPVP = true
}
Zed.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 40,
		CostIncreasePerLevel = 15,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopHealth,
		Cost = 650,
		CostIncreasePerLevel = 150,
		Amount = 0.3
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopDamage,
		Cost = 500,
		CostIncreasePerLevel = 250,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopRange,
		Cost = 375,
		CostIncreasePerLevel = 15,
		Amount = 0.2
	}
}
return Zed