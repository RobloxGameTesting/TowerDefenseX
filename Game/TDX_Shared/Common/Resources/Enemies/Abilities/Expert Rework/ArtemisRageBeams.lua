local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 2,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EffectParentInstanceNames = { "Rage>BeamOrigin>LightningSFX", "Rage>BeamOrigin>LightningVFX" },
	EffectsStartDelay = 2,
	EffectsStopDelay = 5.5,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 40,
		MinimumTargets = 0,
		MaximumTargets = 12,
		NoAffectStealth = true,
		MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
		AffectTargetsWithNoAttack = true,
		TowerBuffNames = { Enums.TowerBuffs.ArtemisRageBeamDebuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Rage>BeamOrigin>LightningBeam",
				MakeNewBeam = true,
				BeamDuration = 3.5,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}