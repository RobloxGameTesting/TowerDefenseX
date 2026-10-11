local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 22,
	Cooldown = 110,
	Animated = true,
	Delay = 43 / 30,
	ExecutionTime = 1.583333333333333,
	AnimationName = "Teleport",
	AutoHandleEffects = true,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.VoidJuggernautClone,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 8,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.8,
			NoCash = true
		}
	}
}