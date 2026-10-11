local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 11,
	Cooldown = 22,
	Animated = true,
	AnimationName = "SwordZap",
	Delay = 0.666,
	ExecutionTime = 2.4669999999999996,
	FaceTarget = true,
	InstantPlayEffectParentInstanceNames = { "SwordZap>SFX" },
	EffectParentInstanceNames = { "SwordZap>Sword>LightningSFX", "SwordZap>Sword>LightningVFX" },
	EffectsStartDelay = 0.666,
	EffectsStopDelay = 1.333,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 25,
		MinimumTargets = 1,
		MaximumTargets = 3,
		NoAffectStealth = true,
		MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
		AffectTargetsWithNoAttack = true,
		TowerBuffNames = { Enums.TowerBuffs.ZeusLightningDebuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "SwordZap>Sword>LightningBeam",
				MakeNewBeam = true,
				BeamDuration = 0.6669999999999999,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}