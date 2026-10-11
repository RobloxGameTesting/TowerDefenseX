local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 39,
	Animated = true,
	Delay = 0.85,
	ExecutionTime = 1.833,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonVFX", "RootPart>SummonSFX" },
	EffectsStopDelay = 1.25,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Fanatic,
			Count = 10,
			StaggerMaxDelay = 0.8,
			MaxSpawnOffsetStuds = 11,
			FavorSpawningBehindParent = true
		}
	}
}