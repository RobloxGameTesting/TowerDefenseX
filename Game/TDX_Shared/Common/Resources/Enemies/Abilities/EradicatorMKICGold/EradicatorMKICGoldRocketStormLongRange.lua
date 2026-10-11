local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.5,
		DamageFalloffRanges = {
			{ Range = 0, Damage = 875 },
			{ Range = 100, Damage = 2000 },
			{ Range = 300, Damage = 4000 }
		}
	},
	StartingCooldown = 2,
	Cooldown = 15,
	Animated = true,
	Delay = 1.417,
	ExecutionTime = 4.2,
	BurstSize = 30,
	BurstInterval = 0,
	ModelBurstSize = 12,
	CustomBurstDelayMap = {
		[3] = 0.155,
		[6] = 0.155,
		[9] = 0.155,
		[12] = 0.155,
		[15] = 0.155,
		[18] = 0.155,
		[21] = 0.155,
		[24] = 0.155,
		[27] = 0.155
	},
	AnimationName = "Rocket Storm",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.EradicatorMKIC_MissileFast,
			Range = 1000,
			MinimumRange = 200,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true,
			TargetHighestRangeTower = true
		}
	},
	EffectParentInstanceNames = { "RocketStormEffects" }
}