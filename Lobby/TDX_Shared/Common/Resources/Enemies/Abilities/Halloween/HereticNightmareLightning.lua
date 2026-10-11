local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	AnimationName = "Lightning",
	Delay = 0.4,
	ExecutionTime = 2.8329999999999997,
	EffectParentInstanceNames = { "Staff>StaffSymbol>LightningSFX", "Staff>StaffSymbol>LightningVFX" },
	EffectsStartDelay = 0.4,
	EffectsStopDelay = 2.3,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 35,
		MinimumTargets = 4,
		MaximumTargets = 10,
		NoAffectStealth = true,
		MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
		AffectTargetsWithNoAttack = true,
		TowerBuffNames = { Enums.TowerBuffs.HereticLightningDebuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Staff>StaffSymbol>LightningBeam",
				MakeNewBeam = true,
				BeamDuration = 1.9,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}