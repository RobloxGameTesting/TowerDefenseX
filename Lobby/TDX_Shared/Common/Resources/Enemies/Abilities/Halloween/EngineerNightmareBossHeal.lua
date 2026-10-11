local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 45,
	Animated = true,
	AnimationName = "Raise Hand",
	FaceTarget = true,
	Delay = 1.2,
	ExecutionTime = 3.7329999999999997,
	EffectParentInstanceNames = { "AttachmentHelper_RightLowerArm>HealVFX" },
	EnemyToEnemyRangedData = {
		Range = 25,
		QueryType = "Weakest",
		BossOrMiniBossOnly = true,
		EnemyBuffNames = { Enums.EnemyBuffs.EngineerNightmareBossHealBuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "AttachmentHelper_RightLowerArm>HealBeam",
				MakeNewBeam = true,
				BeamDuration = 1.5330000000000001,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}