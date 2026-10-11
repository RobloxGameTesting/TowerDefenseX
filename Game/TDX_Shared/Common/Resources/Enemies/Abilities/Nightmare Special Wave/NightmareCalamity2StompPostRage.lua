local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.CalamityStompStun },
	DamageData = { Damage = 1500 },
	Range = 25,
	HitAllTargetsInRange = true
}
return {
	StartingCooldown = 5,
	Cooldown = 120,
	Animated = true,
	Delay = 0.867,
	ExecutionTime = 1.7,
	AnimationName = "Stomp",
	EffectParentInstanceNames = { "StompEffectPart" },
	PrerequisiteAbilityName = Enums.EnemyAbilities.NightmareCalamity2Rage,
	EnemyToTowerRangedDataSequence = { v },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Entity,
			Count = 7,
			StaggerMaxDelay = 0.2,
			MaxSpawnOffsetStuds = 20,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Adversary,
			Count = 6,
			StaggerMaxDelay = 0.2,
			MaxSpawnOffsetStuds = 25,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Gargoyle,
			Count = 12,
			StaggerMaxDelay = 0.2,
			MaxSpawnOffsetStuds = 18,
			FavorSpawningBehindParent = true
		}
	}
}