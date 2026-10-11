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
			EnemyType = Enums.Enemies.VoidGolem,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 14,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.6,
			NoCash = true,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.Umbrix,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 1,
			StaggerMaxDelay = 0.5,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.25,
			ForceSpawnOnDefaultPathIndices = true
		}
	}
}