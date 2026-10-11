local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 50,
	Animated = true,
	Delay = 1.333,
	ExecutionTime = 2,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonVFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.TBBoss3,
			Count = 1,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.TBBoss4,
			Count = 1,
			MaxSpawnOffsetStuds = 5,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.TBFireSpirit,
			Count = 5,
			MaxSpawnOffsetStuds = 5,
			FavorSpawningBehindParent = true,
			NoCash = true
		}
	}
}