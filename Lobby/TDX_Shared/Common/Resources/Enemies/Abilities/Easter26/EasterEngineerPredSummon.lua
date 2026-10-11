local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 150,
	Animated = true,
	Delay = 0.9,
	ExecutionTime = 1.8,
	MaximumUses = 1,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_Predator,
	ParallelAbilityNames = { Enums.EnemyAbilities.EasterEngineerPredSummon_Slam },
	AnimationName = "PredSummon",
	EffectParentInstanceNames = { "PredSummon" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>PredSummon" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.EnergyClone,
			Count = 1,
			PathPercentageLowerBound = 0.4,
			PathPercentageUpperBound = 0.5,
			OverridePathIndices = { 3 },
			FallbackToDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.EnergyClone,
			Count = 1,
			SpawnDelay = 0.25,
			PathPercentageLowerBound = 0.4,
			PathPercentageUpperBound = 0.5,
			OverridePathIndices = { 4 },
			FallbackToDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.Predator,
			Count = 6,
			StaggerMaxDelay = 1,
			PathPercentageLowerBound = 0.15,
			PathPercentageUpperBound = 0.3,
			OverridePathIndices = { 4 },
			FallbackToDefaultPathIndices = true
		}
	}
}