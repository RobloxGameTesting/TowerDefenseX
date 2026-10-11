local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 25,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Body>SpawnVFX", "Body>SpawnSFX" },
	EffectsStopDelay = 2.5,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Goliath,
			Count = 3,
			SpawnDelay = 5,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.Assailant,
			Count = 3,
			SpawnDelay = 0,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
			Count = 12,
			SpawnDelay = 0.222,
			StaggerMaxDelay = 2,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
			Count = 12,
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