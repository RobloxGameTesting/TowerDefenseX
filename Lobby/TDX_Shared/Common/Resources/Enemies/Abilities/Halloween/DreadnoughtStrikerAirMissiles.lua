local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2.5, Damage = 750 },
	StartingCooldown = 3,
	Cooldown = 15,
	Animated = true,
	Delay = 0.9,
	ExecutionTime = 3.333,
	BurstSize = 16,
	BurstInterval = 0.0625,
	AnimationName = "Air Missiles",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.DreadnoughtStrikerMissileAir,
			Range = 80,
			MinimumTargetsInRange = 2,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}