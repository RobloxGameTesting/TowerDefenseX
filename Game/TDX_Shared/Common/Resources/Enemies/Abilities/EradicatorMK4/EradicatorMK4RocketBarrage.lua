local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 1, Damage = 700 },
	StartingCooldown = 3,
	Cooldown = 50,
	Animated = true,
	Delay = 2.55,
	ExecutionTime = 8.666,
	BurstSize = 12,
	BurstInterval = 0.333,
	AnimationName = "MissileBarrage",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.EradicatorMK4SmallRocket,
			Range = 90,
			MinimumTargetsInRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true,
			TargetMinimumValue = 10000
		}
	},
	EffectParentInstanceNames = {}
}