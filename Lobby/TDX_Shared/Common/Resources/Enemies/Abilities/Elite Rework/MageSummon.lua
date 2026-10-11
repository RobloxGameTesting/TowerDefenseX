local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 35,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Root>SummonVFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Skeleton,
			Count = 8,
			StaggerMaxDelay = 1,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.Knyght,
			Count = 2,
			StaggerMaxDelay = 1,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.GiantSkeleton,
			Count = 1,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 19,
			FavorSpawningBehindParent = true,
			NoCash = true
		}
	}
}