local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		DamageFalloffRanges = {
			{ Range = 0, Damage = 3500 },
			{ Range = 80, Damage = 5500 },
			{ Range = 125, Damage = 25000 }
		}
	},
	StartingCooldown = 13,
	Cooldown = 75,
	Animated = true,
	Delay = 0.85,
	ExecutionTime = 3.4170000000000003,
	BurstSize = 3,
	BurstInterval = 0.85,
	AnimationName = "LaserShot",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.BigLaserProjectile,
			Range = 250,
			MinimumRange = 50,
			TargetMostExpensiveTower = true,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = {}
}