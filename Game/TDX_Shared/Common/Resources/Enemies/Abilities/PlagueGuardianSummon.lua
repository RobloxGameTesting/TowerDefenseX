local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 40,
	Animated = true,
	Delay = 0.25,
	ExecutionTime = 2,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonEffectPart" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Tainted,
			Count = 4,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.Tarnished,
			Count = 3,
			MaxSpawnOffsetStuds = 19,
			FavorSpawningBehindParent = true,
			NoCash = true
		}
	}
}