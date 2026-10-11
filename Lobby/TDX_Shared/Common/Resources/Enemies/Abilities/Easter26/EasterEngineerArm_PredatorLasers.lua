local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 8.3,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EffectParentInstanceNames = {},
	EffectsStartDelay = 8.3,
	EffectsStopDelay = 9.55,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 40,
		MinimumTargets = 0,
		MaximumTargets = 7,
		NoAffectStealth = true,
		MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
		AffectTargetsWithNoAttack = true,
		DamageData = { InstantKill = true }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "TransitionPredatorLasers>BeamOrigin>LightningBeam",
				MakeNewBeam = true,
				BeamDuration = 1.25,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}