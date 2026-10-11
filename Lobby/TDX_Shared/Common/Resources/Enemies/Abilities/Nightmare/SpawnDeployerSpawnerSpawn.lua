local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 27,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Body>SpawnVFX", "Body>SpawnSFX" },
	EffectsStopDelay = 2.5,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Grumble,
			Count = 1,
			SpawnDelay = 0,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.Thumper,
			Count = 7,
			ShieldMultiplier = 2,
			SpawnDelay = 0.222,
			StaggerMaxDelay = 4,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.Dreadcubus,
			Count = 1,
			ShieldMultiplier = 1,
			SpawnDelay = 0.222,
			StaggerMaxDelay = 4,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.AerialJuggernaut,
			Count = 1,
			ShieldMultiplier = 1,
			SpawnDelay = 0.222,
			StaggerMaxDelay = 4,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.JX,
			Count = 4,
			ShieldMultiplier = 0,
			SpawnDelay = 0.444,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		}
	},
	SpawnEnemiesNoSummonEffect = true
}