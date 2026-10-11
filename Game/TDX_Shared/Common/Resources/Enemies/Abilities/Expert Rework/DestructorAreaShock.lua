local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 50,
	Animated = true,
	AnimationName = "AreaShock",
	SecondaryAnimationForKeyframeEventsName = "AreaShockDamaged",
	Delay = 1.9,
	ExecutionTime = 5.667,
	InstantPlayEffectParentInstanceNames = { "AreaShock>SFX" },
	EffectParentInstanceNames = { "AreaShock>LightningStorm", "AreaShock>LightningStormGround" },
	EffectsStartDelay = 0.6,
	EffectsStopDelay = 4.6,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 40,
		MinimumTargets = 1,
		MaximumTargets = 9,
		NoAffectStealth = true,
		MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
		AffectTargetsWithNoAttack = true,
		TowerBuffNames = { Enums.TowerBuffs.DestructorAreaShockDebuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "AreaShock>LightningStormBeams>Beam",
				MakeNewBeam = true,
				BeamDuration = 2.6999999999999997,
				BeamOverrideDelay = 1.2999999999999998,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25,
				OriginVarianceXZ = 9,
				OriginVarianceY = 1.2
			}
		}
	}
}