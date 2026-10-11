local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 2,
	Cooldown = 250,
	Animated = true,
	Delay = 1.667,
	ExecutionTime = 2.4330000000000003,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonEffectPart" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Predator,
			Count = 12,
			ShieldMultiplier = 1,
			MaxSpawnOffsetStuds = 60,
			FavorSpawningInFrontOfParent = true
		}
	}
}