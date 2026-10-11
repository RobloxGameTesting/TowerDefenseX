local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 50,
	Animated = true,
	Delay = 0.9,
	ExecutionTime = 2.133,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "RootPart>SummonSFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.VileSeraph,
			Count = 6,
			StaggerMaxDelay = 0.8,
			MaxSpawnOffsetStuds = 18,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.MazeGuardian,
			Count = 1,
			StaggerMaxDelay = 0.8,
			MaxSpawnOffsetStuds = 5,
			FavorSpawningBehindParent = true
		}
	}
}