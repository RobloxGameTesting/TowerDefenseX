local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	DamageData = { Damage = 834 },
	MinimumRange = 13,
	Range = 40,
	TargetMostExpensiveTower = true,
	HitVisualEffectName = Enums.VisualEffects.MinigunHit_3Hits,
	HitVisualEffectVarianceXZ = 0.4,
	HitVisualEffectVarianceY = 0.25
}
return {
	StartingCooldown = 10,
	Cooldown = 55,
	Animated = true,
	Delay = 1.333,
	ExecutionTime = 6,
	BurstSize = 36,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Stage2PalmGuns",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.9,
	PrerequisiteAbilityName = Enums.EnemyAbilities.WretchTransition,
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = { "LeftGun", "RightGun" }
}