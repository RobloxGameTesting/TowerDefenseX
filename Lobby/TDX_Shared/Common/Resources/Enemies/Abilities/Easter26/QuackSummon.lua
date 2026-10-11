local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 17,
	Animated = true,
	Delay = 67 / 60,
	ExecutionTime = 1.95,
	AnimationName = "QuackSummon",
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.BabyDuck,
			Count = 3,
			MaxSpawnOffsetStuds = 5,
			FavorSpawningBehindParent = true
		}
	}
}