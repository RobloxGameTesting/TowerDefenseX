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
			{ Range = 80, Damage = 875 },
			{ Range = 150, Damage = 1500 }
		}
	},
	StartingCooldown = 2,
	Cooldown = 33,
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
			ProjectileName = Enums.Projectiles.EradicatorMKIC_Missile,
			Range = 100,
			MinimumRange = 20,
			MinimumTargetsInRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = { "RocketStormEffects" }
}