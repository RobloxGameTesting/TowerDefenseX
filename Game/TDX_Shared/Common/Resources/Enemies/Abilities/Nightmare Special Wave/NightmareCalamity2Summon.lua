local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 34515,
	Cooldown = 666,
	Animated = true,
	Delay = 0.8,
	ExecutionTime = 1.8,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonEffectPart" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Forsaken,
			Count = 7,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.Adversary,
			Count = 7,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.Imp,
			Count = 12,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		}
	}
}