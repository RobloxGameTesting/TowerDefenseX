local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 4,
		Damage = 200,
		PrimaryTargetMultiplier = 2
	},
	StartingCooldown = 12,
	Cooldown = 36,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.133,
	AnimationName = "Shoot",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			Range = 18,
			TargetMostExpensiveTower = true,
			HitVisualEffectName = Enums.VisualEffects.CorruptedPredatorBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "ShootEffects" }
}