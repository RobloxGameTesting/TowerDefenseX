local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	MaximumRange = 50,
	MinimumTargets = 3,
	MaximumTargets = 7,
	NoAffectStealth = true,
	MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
	AffectTargetsWithNoAttack = true,
	TowerBuffNames = { Enums.TowerBuffs.BunnyOTronBallerinaDebuff }
}
return {
	StartingCooldown = 50,
	Cooldown = 80,
	Animated = true,
	AnimationName = "Ballerina",
	Delay = 3,
	ExecutionTime = 10.017000000000001,
	ParallelAbilityNames = { Enums.EnemyAbilities.BunnyOTronBallerina_Landing },
	InstantPlayEffectParentInstanceNames = { "RootPart>Ballerina" },
	EffectParentInstanceNames = {
		"RootPart>BallerinaBeamSFX",
		"Ballerina>VFX",
		"Ballerina>BeamOrigin1>VFX",
		"Ballerina>BeamOrigin2>VFX"
	},
	EffectsStartDelay = 3,
	EffectsStopDelay = 6.8,
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Ballerina>BeamOrigin1>BeamHolder",
				MakeNewBeam = true,
				BeamDuration = 3.8,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			},
			{
				BeamParentInstanceName = "Ballerina>BeamOrigin2>BeamHolder",
				MakeNewBeam = true,
				BeamDuration = 3.8,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		},
		AlternateBeamsPerTarget = true
	}
}