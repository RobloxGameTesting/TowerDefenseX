local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.5,
		Damage = 525,
		DamagePercentage = 0.3
	},
	StartingCooldown = 5,
	Cooldown = 40,
	Animated = true,
	AnimationName = "SwordThrow",
	Delay = 1.167,
	ExecutionTime = 4.467,
	FaceTarget = true,
	InstantPlayEffectParentInstanceNames = { "SwordThrow>SFX" },
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.ZeusSword,
			Range = 50,
			MinimumRange = 5,
			TargetMostExpensiveTower = true,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}