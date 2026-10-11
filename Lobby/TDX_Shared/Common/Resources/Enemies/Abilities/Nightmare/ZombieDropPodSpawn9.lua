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
			EnemyType = Enums.Enemies.ResurrectedSlammer,
			Count = 1,
			SpawnDelay = 0,
			HealthMultiplier = 0.4,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.MechaMutant,
			Count = 1,
			SpawnDelay = 0,
			HealthMultiplier = 3,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedRailgunner,
			Count = 4,
			SpawnDelay = 1,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.GoldenKnight,
			Count = 11,
			SpawnDelay = 1,
			HealthMultiplier = 4,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		}
	},
	SpawnEnemiesNoSummonEffect = true
}