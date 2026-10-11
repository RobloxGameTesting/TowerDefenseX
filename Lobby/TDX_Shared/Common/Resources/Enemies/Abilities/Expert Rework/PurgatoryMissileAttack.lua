local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local projectileHitData = {
	IsSplash = true,
	SplashRadius = 1,
	Damage = 105,
	BuffName = Enums.TowerBuffs.PurgatoryAntiAirFirerateDebuff
}
return {
	StartingCooldown = 3,
	Cooldown = 20,
	Animated = true,
	Delay = 5 / 6,
	ExecutionTime = 1.8,
	BurstSize = 2,
	BurstInterval = 0.05,
	AnimationName = "Attack",
	FaceTarget = true,
	ForceFaceOverideTime = 0.25,
	ForceFaceOverideTimeInitial = 0.8,
	EffectParentInstanceNames = { "MissileLaunch" },
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.PurgatoryRocket,
			CanTargetAir = false,
			Range = 15,
			MinimumRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	ProjectileHitData = projectileHitData
}