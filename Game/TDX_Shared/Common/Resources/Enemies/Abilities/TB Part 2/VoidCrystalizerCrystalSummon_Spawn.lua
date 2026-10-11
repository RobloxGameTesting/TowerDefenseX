local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 2.66,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.VoidCrystal,
			Count = 1,
			MinimumSpawnOffsetStuds = 7,
			MaxSpawnOffsetStuds = 7,
			NoCash = true
		}
	},
	SpawnEnemiesNoSummonEffect = true
}