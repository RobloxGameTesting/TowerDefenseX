local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2.5, Damage = 200 },
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 0.867,
	ExecutionTime = 5.733,
	BurstSize = 16,
	BurstInterval = 0.25,
	AnimationName = "Ground Missiles",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.DreadnoughtStrikerMissileGround,
			Range = 70,
			MinimumTargetsInRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}