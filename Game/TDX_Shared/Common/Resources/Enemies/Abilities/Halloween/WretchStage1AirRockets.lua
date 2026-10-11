local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2, Damage = 500 },
	StartingCooldown = 10,
	Cooldown = 40,
	Animated = true,
	Delay = 1.133,
	ExecutionTime = 3.0829999999999997,
	BurstSize = 6,
	BurstInterval = 0.2,
	AnimationName = "Stage1AirRockets",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.WretchAirMissile,
			Range = 70,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}