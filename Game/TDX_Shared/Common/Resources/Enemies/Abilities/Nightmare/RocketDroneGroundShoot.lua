local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 1.2, Damage = 400 },
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = true,
	AnimationName = "Ground Shoot",
	Delay = 16 / 15,
	ExecutionTime = 3.103333333333333,
	BurstSize = 3,
	BurstInterval = 0,
	CustomBurstDelayMap = { 17 / 30, 0.4833333333333334 },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
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