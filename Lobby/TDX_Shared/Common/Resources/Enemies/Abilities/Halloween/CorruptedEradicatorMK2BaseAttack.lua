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
	ExecutionTime = 6.25,
	BurstSize = 37,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Minigun Base Attack",
	TriggerRotatingBarrels = true,
	TriggerRotatingBarrelsTime = 5.483,
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1.1,
	EnemyToMapEntityRangedData = {
		Damage = 163,
		Range = 18,
		HitVisualEffectName = Enums.VisualEffects.MinigunHit_3Hits,
		HitVisualEffectVarianceXZ = 0.4,
		HitVisualEffectVarianceY = 0.25
	},
	EffectParentInstanceNames = { "Minigun" }
}