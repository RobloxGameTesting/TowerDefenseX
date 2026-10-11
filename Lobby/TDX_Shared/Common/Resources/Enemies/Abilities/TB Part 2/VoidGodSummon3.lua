local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 5,
	Cooldown = 10,
	Animated = true,
	AnimationName = "Summon",
	AutoHandleEffects = true,
	Delay = 3.283,
	ExecutionTime = 7.2,
	AbilityCycleGroup = "Summon",
	AbilityCycleWaitForSpawnsGoneFraction = 1,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.VoidLich,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 10,
			AdditionalHealthMultiplier = 7,
			StaggerMaxDelay = 7,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.3,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.Neuron,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 60,
			StaggerMaxDelay = 3,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.3,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.SuperSlow,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 20,
			StaggerMaxDelay = 12,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.3,
			ForceSpawnOnDefaultPathIndices = true
		}
	}
}