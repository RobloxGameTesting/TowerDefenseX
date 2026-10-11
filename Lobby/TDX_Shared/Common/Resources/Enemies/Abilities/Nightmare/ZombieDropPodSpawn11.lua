local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = false,
	Delay = 0,
	ExecutionTime = 5,
	MaximumUses = 1,
	Kamikaze = true,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Amalgam,
			Count = 1,
			SpawnDelay = 0,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		}
	},
	SpawnEnemiesNoSummonEffect = true
}