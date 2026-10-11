local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 55,
	Animated = true,
	Delay = 0.9,
	ExecutionTime = 4.967,
	BurstSize = 33,
	BurstInterval = 0.08,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "ChaingunFocus",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.6,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 304 },
			Range = 25,
			TargetRandomTower = true,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.45,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "ChaingunVFX" }
}