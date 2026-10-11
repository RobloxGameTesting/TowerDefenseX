local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 0.6,
	ExecutionTime = 0.867,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonVFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.TBSlow,
			Count = 7,
			StaggerMaxDelay = 1,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.TBSpeedy,
			Count = 3,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 19,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.TBNormal,
			Count = 3,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 19,
			FavorSpawningBehindParent = true,
			NoCash = true
		}
	}
}