local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	StartingCooldownVariance = 2,
	Cooldown = 20,
	CooldownVariance = 7,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.ChariotTurret,
			Count = 1,
			MaxSpawnOffsetStuds = 2,
			FavorSpawningBehindParent = true,
			TransferStealth = true,
			NoCash = true
		}
	}
}