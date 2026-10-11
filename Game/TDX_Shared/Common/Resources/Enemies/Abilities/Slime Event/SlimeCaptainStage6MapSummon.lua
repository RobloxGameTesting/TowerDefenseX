local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 60,
	StartingCooldownVariance = 5,
	Animated = true,
	Delay = 2.333,
	ExecutionTime = 3.5,
	AnimationName = "MapSummon",
	EffectParentInstanceNames = { "MapSummon" },
	EffectsStartDelay = 0.75,
	EffectsStopDelay = 2.55,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.SlimeGolem,
			Count = 3,
			StaggerMaxDelay = 1,
			EvenStagger = true,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.8,
			PathPercentageEvenStagger = true
		}
	}
}