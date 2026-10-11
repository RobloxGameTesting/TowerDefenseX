local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 120,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 2.0500000000000003,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonVFX" },
	EffectsStartDelay = 0.383,
	EffectsStopDelay = 1.85,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.TBHiddenBoss,
			Count = 10,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.TBSpawn1,
			Count = 3,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.TBSpawn2,
			Count = 2,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.TBSpawn3,
			Count = 1,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.TBSpawn4,
			Count = 1,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		},
		{
			EnemyType = Enums.Enemies.TBMystery2,
			Count = 10,
			StaggerMaxDelay = 1.2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5
		}
	}
}