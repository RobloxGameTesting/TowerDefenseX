local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 0.5,
		Damage = 125,
		DamagePercentage = 0.1
	},
	StartingCooldown = 15,
	Cooldown = 80,
	Animated = true,
	Delay = 1.25,
	ExecutionTime = 9.7,
	BurstSize = 12,
	BurstInterval = 0.666,
	ModelBurstSize = 3,
	AnimationName = "Missile Fire Large",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.EradicatorMissile,
			Range = 30,
			MinimumRange = 8,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}