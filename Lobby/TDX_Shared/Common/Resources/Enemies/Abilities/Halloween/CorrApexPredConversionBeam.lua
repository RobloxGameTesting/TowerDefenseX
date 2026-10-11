local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 75,
	Animated = true,
	AnimationName = "ConversionBeam",
	Delay = 1.2,
	ExecutionTime = 2.8,
	EffectParentInstanceNames = { "Eye>ConversionSFX", "Eye>ConversionVFX" },
	EffectsStartDelay = 1.2,
	EffectsStopDelay = 2.2,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 30,
		MinimumTargets = 2,
		MaximumTargets = 4,
		TowerBuffNames = { Enums.TowerBuffs.CorrApexPredConversion }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Eye>ConversionBeam",
				MakeNewBeam = true,
				BeamDuration = 1.0000000000000002,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}