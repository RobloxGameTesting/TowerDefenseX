local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 25,
	Cooldown = 100,
	Animated = true,
	AnimationName = "Conversion",
	Delay = 1.633,
	ExecutionTime = 15.482999999999999,
	EffectParentInstanceNames = {
		"Conversion>Main>SFX",
		"Conversion>Main>VFX",
		"RootPart>SFX>ConversionStart",
		"RootPart>SFX>ConversionLoop"
	},
	EffectsStartDelay = 1.633,
	EffectsStopDelay = 13.667,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 30,
		MinimumTargets = 2,
		MaximumTargets = 4,
		TowerBuffNames = { Enums.TowerBuffs.EmperorConversion }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Conversion>Main>Beam",
				MakeNewBeam = true,
				BeamDuration = 12.033999999999999,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}