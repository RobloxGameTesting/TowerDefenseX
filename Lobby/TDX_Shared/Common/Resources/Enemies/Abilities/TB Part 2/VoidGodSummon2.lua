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
			EnemyType = Enums.Enemies.CorruptedGoldenCommando,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 18,
			StaggerMaxDelay = 9,
			PathPercentageLowerBound = 0.15,
			PathPercentageUpperBound = 0.7,
			NoCash = true,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.VoidJuggernaut1,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 1,
			StaggerMaxDelay = 3,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.15,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.VoidJuggernaut2,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 1,
			StaggerMaxDelay = 3,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.35,
			ForceSpawnOnDefaultPathIndices = true
		}
	}
}