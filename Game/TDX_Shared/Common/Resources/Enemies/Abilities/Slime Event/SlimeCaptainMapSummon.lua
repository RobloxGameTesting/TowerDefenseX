local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 120,
	Animated = true,
	Delay = 3.183,
	ExecutionTime = 5.0329999999999995,
	AnimationName = "MapSummon",
	EffectParentInstanceNames = { "MapSummon" },
	EffectsStartDelay = 1.333,
	EffectsStopDelay = 4,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.SlimeGolem,
			Count = 3,
			StaggerMaxDelay = 1,
			EvenStagger = true,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.8,
			PathPercentageEvenStagger = true
		},
		{
			EnemyType = Enums.Enemies.SlimeSoldier,
			Count = 25,
			StaggerMaxDelay = 1,
			EvenStagger = true,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.9,
			PathPercentageEvenStagger = true
		}
	}
}