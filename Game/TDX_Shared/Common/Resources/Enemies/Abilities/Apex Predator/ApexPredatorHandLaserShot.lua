local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 5000 },
	StartingCooldown = 3,
	Cooldown = 60,
	Animated = true,
	Delay = 1.233,
	ExecutionTime = 1.6,
	AnimationName = "LaserHandShot",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.SuperBigLaserProjectile,
			Range = 40,
			MinimumRange = 10,
			TargetRandomTower = true,
			TargetMinimumValue = 1500,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "LaserHandShotEffectsPart" }
}