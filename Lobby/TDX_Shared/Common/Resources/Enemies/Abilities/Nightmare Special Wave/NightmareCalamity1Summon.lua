local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	StartingCooldownVariance = 5,
	Cooldown = 666,
	Animated = true,
	Delay = 0.8,
	ExecutionTime = 1.8,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonEffectPart" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Cataclysmic,
			Count = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.Catastrophic,
			Count = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.Entity,
			Count = 35,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.Adversary,
			Count = 35,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.Redacted,
			Count = 35,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		}
	}
}