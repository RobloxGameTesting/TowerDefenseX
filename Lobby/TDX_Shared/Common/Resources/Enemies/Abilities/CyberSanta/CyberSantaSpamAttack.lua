local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 45,
	Animated = true,
	Delay = 1.3,
	ExecutionTime = 6.7,
	AnimationName = "Spam Attack",
	EffectParentInstanceNames = {
		"FootstepSoundsPart",
		"SpamShotVFX1",
		"SpamShotVFX2",
		"SpamShotVFX3",
		"SpamShotVFX4"
	},
	EffectsStartDelay = 13 / 12,
	EffectsStopDelay = 5.05,
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.CyberSantaSpamAttackDebuff },
			Range = 35,
			ArcSpreadAngle = 105,
			EradicatorFlamethrowerData = {
				StartTime = 1.3,
				StopTime = 5.05,
				ArcTiming = {
					{ Time = 1.3, Angle = 0 },
					{ Time = 1.5833333333333335, Angle = 0 },
					{ Time = 2.15, Angle = 55 },
					{ Time = 3, Angle = 55 },
					{ Time = 3.75, Angle = 0 },
					{ Time = 4.45, Angle = -55 },
					{ Time = 5.05, Angle = -55 }
				},
				BufferAngle = 16
			},
			MinimumTargetsInRange = 4
		}
	}
}