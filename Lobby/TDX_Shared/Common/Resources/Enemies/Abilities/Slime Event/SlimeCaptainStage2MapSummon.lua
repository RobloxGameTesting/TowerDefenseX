local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 2,
	Cooldown = 60,
	StartingCooldownVariance = 5,
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
			Count = 2,
			StaggerMaxDelay = 1,
			EvenStagger = true,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.8,
			PathPercentageEvenStagger = true
		},
		{
			EnemyType = Enums.Enemies.SlimeBloat,
			Count = 7,
			AdditionalShieldMultiplier = 0.5,
			StaggerMaxDelay = 1,
			EvenStagger = true,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.7,
			PathPercentageEvenStagger = true
		},
		{
			EnemyType = Enums.Enemies.SlimeMob,
			Count = 9,
			AdditionalShieldMultiplier = 1,
			StaggerMaxDelay = 1,
			EvenStagger = true,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.7,
			PathPercentageEvenStagger = true
		}
	}
}