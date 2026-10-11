local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 6,
	StartingCooldownVariance = 2,
	Cooldown = 25,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 4.55,
	BurstSize = 16,
	BurstInterval = 0.12,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Gun",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.7,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 22 },
			Range = 15,
			TargetRandomTower = true,
			TargetPathEntitiesIfNoTowers = true,
			PathEntityInitialQueryReduceRange = 3,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "Tommy Gun>Shoot" }
}