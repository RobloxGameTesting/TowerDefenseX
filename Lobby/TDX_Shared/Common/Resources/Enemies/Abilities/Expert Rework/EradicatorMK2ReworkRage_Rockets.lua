local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 3, Damage = 225, DamagePercentage = 0.2 },
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 15.317,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	BurstSize = 22,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		[4] = 0.15000000000000036,
		[8] = 0.08300000000000018,
		[12] = 0.13299999999999912,
		[16] = 0.08399999999999963,
		[19] = 0.10000000000000142
	},
	EnemyToTowerRangedDataSequence = {
		{
			TargetPathIfNoTargets = true,
			TargetPathIfNoTargetsRangeVariance = 50,
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.EradicatorMK2ReworkRocket,
			Range = 70,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}