local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 30,
	Animated = true,
	AnimationName = "Summon",
	Delay = 1.8,
	ExecutionTime = 2.4669999999999996,
	EffectParentInstanceNames = { "Root>SummonVFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.GoldenKnight,
			Count = 4,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.Knyght,
			Count = 3,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		}
	}
}