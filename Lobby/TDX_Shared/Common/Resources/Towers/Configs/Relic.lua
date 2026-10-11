local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Relic = {
	AttackDisabled = true,
	LimitMap = { 5, 2, 2, 1 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 425,
			Health = 250,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 1,
			Range = 1,
			StealthDetection = false,
			SpawnPathEntityData = {
				{
					PathEntityType = Enums.PathEntities.Bandit0,
					StartDelay = 10,
					Interval = 55,
					MaximumCount = 4
				}
			},
			IgnoreObstacles = true,
			Description = "",
			Icon = "rbxassetid://97671592868318"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 365,
				HealthIncrease = 100,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Bandit1,
						StartDelay = 10,
						Interval = 55,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 4
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Bandit0 },
				Description = "ARMOR",
				Icon = "rbxassetid://79408176942890",
				UpgradeIcon = "rbxassetid://82364628098408"
			},
			{
				Cost = 825,
				HealthIncrease = 175,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Zealot,
						StartDelay = 10,
						Interval = 45,
						MaximumCount = 4
					}
				},
				Description = "KNIGHTS",
				Icon = "rbxassetid://100023402636432",
				UpgradeIcon = "rbxassetid://119316578635341"
			},
			{
				Cost = 2500,
				HealthIncrease = 300,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Archer,
						StartDelay = 10,
						Interval = 40,
						BurstSize = 2,
						BurstInterval = 1,
						MaximumCount = 4
					}
				},
				Description = "ARCHER",
				Icon = "rbxassetid://87463018460969",
				UpgradeIcon = "rbxassetid://135803168465535"
			},
			{
				Cost = 13750,
				HealthIncrease = 1000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Warden,
						StartDelay = 10,
						Interval = 50,
						MaximumCount = 4
					}
				},
				Description = "WARDEN",
				Icon = "rbxassetid://129036020239637",
				UpgradeIcon = "rbxassetid://106511748534241"
			},
			{
				Cost = 1000000,
				HealthIncrease = 15000,
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.Seraph,
						StartDelay = 11,
						Interval = 40,
						MaximumCount = 4
					},
					{
						PathEntityType = Enums.PathEntities.OverseerRework,
						StartDelay = 10,
						Interval = 230,
						BurstSize = 1,
						BurstInterval = 1,
						MaximumCount = 3
					}
				},
				RemoveSpawnPathEntityNames = { Enums.PathEntities.Bandit1 },
				AbilityNames = { Enums.TowerAbilities.RelicSummon },
				Description = "OVERSEER & SERAPH",
				Icon = "rbxassetid://89300401092112",
				UpgradeIcon = "rbxassetid://128732447802306"
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
	BannedInPVP = true
}
Relic.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 75,
		CostIncreasePerLevel = 25,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopHealth,
		Cost = 1000,
		CostIncreasePerLevel = 800,
		Amount = 0.35
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopDamage,
		Cost = 825,
		CostIncreasePerLevel = 725,
		Amount = 0.3
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopRange,
		Cost = 750,
		CostIncreasePerLevel = 200,
		Amount = 0.1
	}
}
return Relic