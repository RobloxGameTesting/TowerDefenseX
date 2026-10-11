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
		Multiplier = 2,
		MaxSpawnOffsetStuds = 1,
		FavorSpawningBehindParent = true,
		IgnoreBoss = false,
		IgnoreList = {
			Enums.Enemies.Multiplier1,
			Enums.Enemies.Multiplier2,
			Enums.Enemies.Multiplier3,
			Enums.Enemies.MultiplierT,
			Enums.Enemies.MultiplierX
		},
		NoCash = true,
		SpeedBoostMultiplier = 1.3
	}
}