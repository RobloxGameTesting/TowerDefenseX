local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local projectileHitData = {
	IsSplash = true,
	SplashRadius = 1.5,
	Damage = 350,
	BuffName = Enums.TowerBuffs.PurgatoryAntiAirFirerateDebuff
}
return {
	StartingCooldown = 0,
	Cooldown = 12,
	Animated = true,
	Delay = 5 / 6,
	ExecutionTime = 1.8,
	BurstSize = 2,
	BurstInterval = 7 / 30,
	AnimationName = "AAAttack",
	FaceTarget = true,
	ForceFaceOverideTime = 0.25,
	ForceFaceOverideTimeInitial = 0.8,
	EffectParentInstanceNames = { "MissileLaunchAA" },
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.PurgatoryRocket,
			NoTargetGround = true,
			CanTargetAir = true,
			Range = 20,
			MinimumRange = 3,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	ProjectileHitData = projectileHitData
}