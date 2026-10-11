local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	MaximumRange = 35,
	MinimumTargets = 4,
	MaximumTargets = 10,
	NoAffectStealth = true,
	MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
	AffectTargetsWithNoAttack = true,
	TowerBuffNames = { Enums.TowerBuffs.EmperorZapDamage, Enums.TowerBuffs.EmperorZapDebuff }
}
return {
	StartingCooldown = 12,
	Cooldown = 50,
	Animated = true,
	Delay = 2.2,
	ExecutionTime = 13.1,
	AnimationName = "HealAndZap",
	ParallelAbilityNames = { Enums.EnemyAbilities.EmperorHealAndZap_Heal },
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	EffectParentInstanceNames = { "HealAndZap" },
	EffectsStartDelay = 2.2,
	EffectsStopDelay = 11.55,
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "HealAndZapBeam>BeamHolder>Beam",
				MakeNewBeam = true,
				BeamDuration = 9.350000000000001,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}