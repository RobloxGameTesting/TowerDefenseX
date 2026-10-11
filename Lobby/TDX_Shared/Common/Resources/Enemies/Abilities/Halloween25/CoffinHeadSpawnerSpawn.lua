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
	ExecutionTime = 11,
	MaximumUses = 1,
	EffectParentInstanceNames = {},
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.RedSkeleton,
			Count = 10,
			SpawnDelay = 0,
			StaggerMaxDelay = 6,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 0.1,
			TransferStealth = true,
			NoCash = true
		}
	},
	SpawnEnemiesNoSummonEffect = true,
	Kamikaze = true
}