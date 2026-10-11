local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 35,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 1.467,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonVFX", "Root>SummonSFX" },
	EffectsStopDelay = 1.05,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.FrostSpirit,
			Count = 2,
			StaggerMaxDelay = 0.3,
			MaxSpawnOffsetStuds = 5,
			FavorSpawningBehindParent = true
		}
	}
}