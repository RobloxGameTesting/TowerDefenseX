local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	StartingCooldownVariance = 9,
	Cooldown = 120,
	Animated = true,
	Delay = 0.867,
	ExecutionTime = 1.7,
	AnimationName = "Stomp",
	EffectParentInstanceNames = { "StompEffectPart" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.CalamityStompStun },
			DamageData = { Damage = 1500 },
			Range = 25,
			HitAllTargetsInRange = true
		}
	},
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Entity,
			Count = 1,
			MaxSpawnOffsetStuds = 12,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Adversary,
			Count = 1,
			MaxSpawnOffsetStuds = 4,
			FavorSpawningBehindParent = true
		}
	}
}