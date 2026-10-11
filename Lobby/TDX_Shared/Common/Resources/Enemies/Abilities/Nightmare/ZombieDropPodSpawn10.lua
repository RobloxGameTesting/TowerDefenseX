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
			EnemyType = Enums.Enemies.E02,
			Count = 3,
			SpawnDelay = 0,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.XJuggernaut,
			Count = 2,
			SpawnDelay = 2,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.XOrdinal,
			Count = 6,
			SpawnDelay = 2,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		}
	},
	SpawnEnemiesNoSummonEffect = true
}