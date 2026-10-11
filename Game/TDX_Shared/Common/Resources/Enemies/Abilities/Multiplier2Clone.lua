local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EnemyCloneData = {
		Radius = 6,
		Multiplier = 3,
		MaxSpawnOffsetStuds = 1,
		FavorSpawningBehindParent = true,
		IgnoreBoss = true,
		IgnoreList = {
			Enums.Enemies.Multiplier1,
			Enums.Enemies.Multiplier2,
			Enums.Enemies.Multiplier3,
			Enums.Enemies.MultiplierT,
			Enums.Enemies.MultiplierX,
			Enums.Enemies.MultiplierAdmin
		},
		NoCash = true,
		SpeedBoostMultiplier = 1.3
	}
}