local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		Damage = 25,
		IsSplash = false,
		BuffName = Enums.TowerBuffs.MageFirerateDebuff
	},
	StartingCooldown = 1,
	Cooldown = 5,
	Animated = true,
	AnimationName = "Attack",
	Delay = 2 / 3,
	ExecutionTime = 1.35,
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.MageFireball, Range = 13, TargetRandomTower = true }
	}
}