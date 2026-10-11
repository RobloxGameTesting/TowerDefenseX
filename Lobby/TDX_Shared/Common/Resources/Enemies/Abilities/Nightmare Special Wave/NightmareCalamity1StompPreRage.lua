local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	StartingCooldownVariance = 7,
	Cooldown = 85,
	Animated = true,
	Delay = 0.867,
	ExecutionTime = 1.7,
	AnimationName = "Stomp",
	EffectParentInstanceNames = { "StompEffectPart" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.CalamityStompStun },
			DamageData = { Damage = 1500 },
			Range = 35,
			HitAllTargetsInRange = true
		}
	},
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Entity,
			Count = 8,
			StaggerMaxDelay = 0.2,
			MaxSpawnOffsetStuds = 32,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Redacted,
			Count = 10,
			StaggerMaxDelay = 0.2,
			MaxSpawnOffsetStuds = 35,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Imp,
			Count = 5,
			StaggerMaxDelay = 0.2,
			MaxSpawnOffsetStuds = 17,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Adversary,
			Count = 8,
			StaggerMaxDelay = 0.2,
			MaxSpawnOffsetStuds = 28,
			FavorSpawningBehindParent = true
		}
	}
}