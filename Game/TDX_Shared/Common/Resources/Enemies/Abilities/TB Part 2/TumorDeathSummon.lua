local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	ExecutionTime = 0,
	CanRunInParallel = true,
	Delay = 23 / 30,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Pustle,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 3,
			MaxSpawnOffsetStuds = 3,
			SpeedBoostMultiplier = 2
		}
	}
}