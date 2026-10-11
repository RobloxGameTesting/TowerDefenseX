local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 6,
	StartingCooldownVariance = 2,
	Cooldown = 5,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.8,
	BurstSize = 9,
	BurstInterval = 0.165,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Attack",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.7,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 92 },
			Range = 15,
			TargetRandomTower = true,
			TargetPathEntitiesIfNoTowers = true,
			PathEntityInitialQueryReduceRange = 3,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "Gun>Shoot" }
}