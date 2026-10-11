local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 1.2, Damage = 300 },
	StartingCooldown = 7,
	Cooldown = 25,
	Animated = true,
	Delay = 0.683,
	ExecutionTime = 2.7330000000000005,
	BurstSize = 8,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		0.10000000000000009,
		0.03399999999999981,
		0.10000000000000009,
		0.08299999999999996,
		0.050000000000000044,
		0.050000000000000044,
		0.24999999999999978
	},
	AnimationName = "Attack",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.AvatarMissile,
			Range = 40,
			MinimumRange = 10,
			MinimumTargetsInRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}