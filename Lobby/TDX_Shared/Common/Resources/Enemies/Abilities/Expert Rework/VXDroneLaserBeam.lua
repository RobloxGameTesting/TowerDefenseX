local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 32,
	Animated = true,
	AnimationName = "LaserBeam",
	Delay = 0.333,
	ExecutionTime = 3.8,
	FaceTarget = true,
	ForceFaceOverideTime = 0.75,
	ForceFaceOverideTimeInitial = 0.25,
	InstantPlayEffectParentInstanceNames = { "LaserBeam>SFX" },
	EffectParentInstanceNames = { "LaserBeam>BeamOrigin>LightningSFX", "LaserBeam>BeamOrigin>LightningVFX" },
	EffectsStartDelay = 0.333,
	EffectsStopDelay = 3.333,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 32,
		MinimumTargets = 1,
		MaximumTargets = 1,
		NoAffectStealth = true,
		MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
		AffectTargetsWithNoAttack = true,
		TowerBuffNames = { Enums.TowerBuffs.VXDroneLaserBeamDebuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "LaserBeam>BeamOrigin>LightningBeam",
				MakeNewBeam = true,
				BeamDuration = 3,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}