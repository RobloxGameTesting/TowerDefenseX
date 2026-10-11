local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 35,
	Animated = true,
	AnimationName = "HealBook",
	FaceTarget = true,
	Delay = 1.067,
	ExecutionTime = 3.133,
	EffectParentInstanceNames = { "Book>BookMain>HealSFX", "Book>BookMain>HealVFX" },
	EffectsStopDelay = 1.833,
	EnemyToEnemyRangedData = {
		Range = 25,
		QueryType = "Strongest",
		HealData = { ShieldGain = 1000, ShieldGainPercentageOfTargetMaxHealth = 0.1 }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Book>BookMain>HealBeam",
				MakeNewBeam = true,
				BeamDuration = 0.766,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}