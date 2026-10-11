local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 20,
	Animated = true,
	AnimationName = "PlasmaBeam",
	Delay = 1,
	ExecutionTime = 4.8,
	FaceTarget = true,
	EffectParentInstanceNames = {
		"PlasmaBeam>SFX",
		"PlasmaBeam>BeamOrigin>LightningSFX",
		"PlasmaBeam>BeamOrigin>LightningVFX"
	},
	EffectsStartDelay = 1,
	EffectsStopDelay = 4,
	EnemyToTowerRangedDataSequence = {
		{
			Range = 40,
			MinimumRange = 2,
			TargetHighestRangeTower = true,
			TargetMinimumValue = 20000,
			TowerBuffNames = { Enums.TowerBuffs.ArtemisPlasmaBeamDebuff }
		}
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "PlasmaBeam>BeamOrigin>LightningBeam",
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