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
			EnableDisabledAttacks = true,
			Count = 7,
			StaggerMaxDelay = 0.3,
			OverridePathIndices = {
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8,
				9,
				10,
				11,
				12
			},
			FavorSpawningBehindParent = true,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.4
		},
		{
			EnemyType = Enums.Enemies.SnowPredator,
			EnableDisabledAttacks = true,
			Count = 7,
			StaggerMaxDelay = 0.3,
			OverridePathIndices = {
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8,
				9,
				10,
				11,
				12
			},
			FavorSpawningBehindParent = true,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.4
		}
	}
}