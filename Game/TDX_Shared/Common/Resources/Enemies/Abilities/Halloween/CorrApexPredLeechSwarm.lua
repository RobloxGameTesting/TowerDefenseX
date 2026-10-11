local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		BuffName = Enums.TowerBuffs.CorrApexPredLeech,
		SpawnAttachmentEntityType = Enums.AttachmentEntities.Leech,
		SpawnAttachmentEntityIsBuffDependent = true
	},
	StartingCooldown = 30,
	Cooldown = 100,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	BurstSize = 3,
	BurstInterval = 0.1,
	CustomBurstDelayMap = { [2] = 0.01, [3] = 0.05, [4] = 0.1, [5] = 0.12 },
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.LeechProjectileFromBody,
			Range = 25,
			IgnoreConvertedTargets = true,
			TargetRandomTower = true,
			TargetMinimumValue = 2000,
			MinimumTargetsInRange = 3,
			TowerTypeIgnoreMap = {
				[Enums.Towers.Helicopter] = true,
				[Enums.Towers.CryoHelicopter] = true,
				[Enums.Towers.XWMTurret] = true,
				[Enums.Towers.Sentry] = true,
				[Enums.Towers.Warship] = true,
				[Enums.Towers.GoldenWarship] = true,
				[Enums.Towers.Farm] = true,
				[Enums.Towers.ArmoredFactory] = true,
				[Enums.Towers.Barracks] = true,
				[Enums.Towers.EDJ] = true,
				[Enums.Towers.Medic] = true,
				[Enums.Towers.MineLayer] = true,
				[Enums.Towers.GoldenMineLayer] = true,
				[Enums.Towers.Zed] = true,
				[Enums.Towers.BehemothFactory] = true,
				[Enums.Towers.ShieldTower] = true
			}
		}
	},
	EffectParentInstanceNames = { "RootPart>LeechSummonSFX" },
	EffectsOnlyOnInitialBurst = true
}