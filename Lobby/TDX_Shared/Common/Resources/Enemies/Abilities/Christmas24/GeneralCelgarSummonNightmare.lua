local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 35,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 1.867,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonVFX", "Torso>SummonSFX" },
	EffectsStopDelay = 2.5,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.EvergrimSummoner,
			Count = 6,
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
			PathPercentageUpperBound = 0.4,
			HealthMultiplier = 1,
			ShieldMultiplier = 2
		},
		{
			EnemyType = Enums.Enemies.FrozenGladiator,
			Count = 18,
			StaggerMaxDelay = 0.6,
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
			FavorSpawningBehindParent = false,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.4,
			HealthMultiplier = 1,
			ShieldMultiplier = 2
		}
	}
}