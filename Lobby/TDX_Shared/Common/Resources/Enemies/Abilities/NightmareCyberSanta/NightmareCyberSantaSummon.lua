local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 8,
	Cooldown = 35,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 0.97,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonEffectPart" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Wendigo,
			Count = 3,
			MaxSpawnOffsetStuds = 11,
			FavorSpawningInFrontOfParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.SuperNaughty,
			Count = 1,
			MaxSpawnOffsetStuds = 11,
			FavorSpawningInFrontOfParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.Monster,
			Count = 2,
			MaxSpawnOffsetStuds = 11,
			FavorSpawningInFrontOfParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ElfGuardian,
			Count = 2,
			MaxSpawnOffsetStuds = 11,
			FavorSpawningInFrontOfParent = true,
			NoCash = true
		}
	}
}