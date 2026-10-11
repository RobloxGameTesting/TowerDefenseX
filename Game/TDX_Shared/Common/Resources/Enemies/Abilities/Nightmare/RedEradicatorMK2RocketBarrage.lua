local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.5,
		Damage = 500,
		DamagePercentage = 0.05
	},
	StartingCooldown = 2,
	Cooldown = 25,
	Animated = true,
	Delay = 29 / 12,
	ExecutionTime = 4,
	BurstSize = 16,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		[3] = 0.1,
		[6] = 0.1167,
		[8] = 0.27,
		[11] = 0.1167,
		[14] = 0.0833
	},
	AnimationName = "Missile Fire",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.EradicatorMK2Rocket,
			Range = 70,
			MinimumTargetsInRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = { "RocketBarrageEffects" }
}