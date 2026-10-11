local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		BuffName = Enums.TowerBuffs.CorruptedPredatorLeech,
		SpawnAttachmentEntityType = Enums.AttachmentEntities.Leech,
		SpawnAttachmentEntityIsBuffDependent = true
	},
	StartingCooldown = 12,
	Cooldown = 35,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	BurstSize = 2,
	BurstInterval = 0.1,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.LeechProjectileFromBody,
			Range = 22,
			IgnoreConvertedTargets = true,
			TargetRandomTower = true,
			TargetMinimumValue = 2000,
			MinimumTargetsInRange = 2,
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
	EffectParentInstanceNames = { "Root>LeechSummonSFX" },
	EffectsOnlyOnInitialBurst = true
}