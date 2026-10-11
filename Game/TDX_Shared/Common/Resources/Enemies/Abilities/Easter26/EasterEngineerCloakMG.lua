local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 55,
	Animated = true,
	Delay = 2,
	ExecutionTime = 6.8,
	BurstSize = 31,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "CloakMG",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1.4,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 484 },
			Range = 35,
			MinimumRange = 6,
			TargetMostExpensiveTower = true,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "CloakMG" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>CloakMG" }
}