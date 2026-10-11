local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 0.5, Damage = 11000 },
	StartingCooldown = 10,
	Cooldown = 40,
	Animated = true,
	Delay = 0.983,
	ExecutionTime = 2.033,
	FaceTarget = true,
	ForceFaceOverideTime = 0.6,
	AnimationName = "Stage1Railgun",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = false,
			Range = 55,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = false,
			TargetMostExpensiveTower = true,
			HitVisualEffectName = Enums.VisualEffects.PurpleMissileBlastLarge,
			HitVisualEffectVarianceXZ = 0.7,
			HitVisualEffectVarianceY = 0.7
		}
	},
	EffectParentInstanceNames = { "Railgun" }
}