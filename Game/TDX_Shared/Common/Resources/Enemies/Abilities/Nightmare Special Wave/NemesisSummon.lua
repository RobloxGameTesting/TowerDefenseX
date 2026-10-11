local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 75,
	Animated = true,
	Delay = 0,
	ExecutionTime = 9.8,
	AnimationName = "Summon",
	MaxPathPercentageCanUse = 0.8,
	EffectParentInstanceNames = { "FX>Summon>Immediate" },
	EffectsStartDelay = 0,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Brimstone,
			Count = 3,
			SpawnDelay = 14 / 3,
			StaggerMaxDelay = 1,
			MaxSpawnOffsetStuds = 50,
			FavorSpawningInFrontOfParent = true
		},
		{
			EnemyType = Enums.Enemies.Fragment,
			Count = 1,
			SpawnDelay = 14 / 3,
			StaggerMaxDelay = 1,
			MaxSpawnOffsetStuds = 50,
			FavorSpawningInFrontOfParent = true
		},
		{
			EnemyType = Enums.Enemies.Adversary,
			Count = 6,
			SpawnDelay = 14 / 3,
			StaggerMaxDelay = 1,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningInFrontOfParent = true
		},
		{
			EnemyType = Enums.Enemies.CalamityReaper,
			Count = 2,
			SpawnDelay = 14 / 3,
			StaggerMaxDelay = 1,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningInFrontOfParent = true
		},
		{
			EnemyType = Enums.Enemies.WeepingAngel,
			Count = 7,
			SpawnDelay = 79 / 12,
			StaggerMaxDelay = 1,
			MaxSpawnOffsetStuds = 35,
			FavorSpawningInFrontOfParent = true
		}
	}
}