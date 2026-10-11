local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 0.5,
		Damage = 475,
		DamagePercentage = 0.1
	},
	StartingCooldown = 6,
	Cooldown = 30,
	Animated = true,
	Delay = 1.25,
	ExecutionTime = 2.9,
	BurstSize = 3,
	BurstInterval = 0.333,
	AnimationName = "Missile Fire",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.EradicatorMissile,
			Range = 15,
			MinimumRange = 8,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true
		}
	}
}