local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 1.2, Damage = 1000 },
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = true,
	AnimationName = "All Shoot",
	Delay = 97 / 60,
	ExecutionTime = 259 / 75,
	BurstSize = 8,
	BurstInterval = 0.05,
	FaceTarget = false,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.RocketDroneMissile,
			Range = 40,
			MinimumRange = 10,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}