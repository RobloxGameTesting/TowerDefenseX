local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		Damage = 10,
		BuffName = Enums.TowerBuffs.JavelinDamageDebuff
	},
	StartingCooldown = 3,
	Cooldown = 5,
	Animated = true,
	Delay = 49 / 60,
	ExecutionTime = 2.1830000000000003,
	AnimationName = "Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.JavelinSpear, Range = 13, TargetRandomTower = true }
	}
}