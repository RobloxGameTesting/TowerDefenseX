local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 55,
	Animated = true,
	Delay = 1.7,
	ExecutionTime = 4.683,
	BurstSize = 18,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Minigun Focus",
	TriggerRotatingBarrels = true,
	TriggerRotatingBarrelsTime = 3.5,
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1.1,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 778 },
			MinimumRange = 8,
			Range = 25,
			TargetMostExpensiveTower = true,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit_3Hits,
			HitVisualEffectVarianceXZ = 0.4,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "Minigun" }
}