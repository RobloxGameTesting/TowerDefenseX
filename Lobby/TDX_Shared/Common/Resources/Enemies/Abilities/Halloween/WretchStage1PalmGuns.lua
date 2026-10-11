local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 55,
	Animated = true,
	Delay = 1.333,
	ExecutionTime = 5.883,
	BurstSize = 36,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Stage1PalmGuns",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.9,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1112 },
			MinimumRange = 13,
			Range = 40,
			TargetMostExpensiveTower = true,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit_3Hits,
			HitVisualEffectVarianceXZ = 0.4,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "LeftGun", "RightGun" }
}