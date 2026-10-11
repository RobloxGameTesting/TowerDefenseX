local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 1.2, Damage = 500 },
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = true,
	AnimationName = "Aerial Shoot",
	Delay = 29 / 30,
	ExecutionTime = 991 / 300,
	BurstSize = 8,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		0.11666666666666659,
		0,
		0.050000000000000044,
		0.3833333333333333,
		0.06666666666666665,
		0.30000000000000004,
		4193 / 30,
		0.3500000000000001
	},
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
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