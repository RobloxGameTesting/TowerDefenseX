local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 28,
	Cooldown = 10000,
	Animated = true,
	Delay = 0.867,
	ExecutionTime = 1.7,
	MaximumUses = 1,
	AnimationName = "Stomp",
	EffectParentInstanceNames = { "StompEffectPart" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.CalamityStompStun },
			DamageData = { Damage = 500 },
			Range = 25,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		DamageData = { InstantKill = true },
		MaximumTargets = 15,
		AffectTargetsWithNoAttack = true,
		TowerTypeIgnoreMap = { [Enums.Towers.Warship] = true, [Enums.Towers.GoldenWarship] = true }
	},
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Entity,
			Count = 2,
			MaxSpawnOffsetStuds = 7,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Redacted,
			Count = 1,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Adversary,
			Count = 2,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningBehindParent = true
		}
	}
}