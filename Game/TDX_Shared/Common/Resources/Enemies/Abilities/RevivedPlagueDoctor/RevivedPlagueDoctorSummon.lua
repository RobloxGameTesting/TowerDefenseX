local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 40,
	Animated = true,
	Delay = 1.1,
	ExecutionTime = 61 / 30,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonEffectPart" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.ResurrectedRanger1,
			Count = 2,
			MaxSpawnOffsetStuds = 7,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedRanger2,
			Count = 1,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
			Count = 2,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedJuggernaut,
			Count = 3,
			MaxSpawnOffsetStuds = 7,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
			Count = 2,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningBehindParent = true
		}
	}
}