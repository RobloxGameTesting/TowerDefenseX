local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 7,
	Cooldown = 70,
	Animated = true,
	Delay = 0.75,
	ExecutionTime = 1.767,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonEffectPart" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.ResurrectedRanger1,
			Count = 5,
			MaxSpawnOffsetStuds = 9,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedRanger2,
			Count = 4,
			MaxSpawnOffsetStuds = 9,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.Wrecker,
			Count = 1,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.KnightRework,
			Count = 5,
			MaxSpawnOffsetStuds = 20,
			FavorSpawningBehindParent = true
		}
	}
}