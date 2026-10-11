local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 20,
	Animated = true,
	Delay = 1.583,
	ExecutionTime = 4.7,
	BurstSize = 18,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "AssaultRifle",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.9,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1667 },
			Range = 25,
			TargetRandomTower = true,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "AssaultRifle" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>AssaultRifle" }
}