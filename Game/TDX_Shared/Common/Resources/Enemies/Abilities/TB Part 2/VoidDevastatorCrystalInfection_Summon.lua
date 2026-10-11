local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 5,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Blister,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 5,
			StaggerMaxDelay = 10.5,
			PathPercentageLowerBound = 0.1,
			PathPercentageUpperBound = 0.6,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.CorruptedGoldenCommando,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 7,
			StaggerMaxDelay = 10.5,
			PathPercentageLowerBound = 0.4,
			PathPercentageUpperBound = 0.6,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.VoidRunner,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 1,
			StaggerMaxDelay = 10.5,
			PathPercentageLowerBound = 0.1,
			PathPercentageUpperBound = 0.4,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.VoidWarden,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 12,
			StaggerMaxDelay = 10.5,
			PathPercentageLowerBound = 0.1,
			PathPercentageUpperBound = 0.5,
			NoCash = true
		}
	}
}