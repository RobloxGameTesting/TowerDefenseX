local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 30,
	Animated = true,
	Delay = 1.433,
	ExecutionTime = 9.8,
	BurstSize = 63,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Attack",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1.1,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 445 },
			Range = 25,
			TargetRandomTower = true,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = {
		"RootPart>MinigunSFX",
		"AttachmentHelper_Gun>MinigunVFX",
		"AttachmentHelper_Gun>MinigunVFX2"
	}
}