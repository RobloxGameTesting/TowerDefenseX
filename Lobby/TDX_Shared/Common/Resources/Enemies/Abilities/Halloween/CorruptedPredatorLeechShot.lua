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
	StartingCooldown = 15,
	Cooldown = 15,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.133,
	AnimationName = "Shoot",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.LeechProjectile,
			Range = 18,
			IgnoreConvertedTargets = true,
			TargetRandomTower = true,
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
	EffectParentInstanceNames = { "LeechShootEffects" }
}