local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 11,
	Cooldown = 35,
	Animated = true,
	AnimationName = "SwordZap",
	Delay = 0.8,
	ExecutionTime = 4.7829999999999995,
	AutoHandleEffects = true,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 45,
		MinimumTargets = 1,
		MaximumTargets = 5,
		NoAffectStealth = true,
		MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = true, NoDetectStealth = true },
		AffectTargetsWithNoAttack = true,
		TowerBuffNames = {
			Enums.TowerBuffs.ExoVoidSwordZapDamageDebuff,
			Enums.TowerBuffs.ExoVoidSwordZapDamagePerSecond
		}
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "SwordZapBeams>Main>LightningBeam",
				MakeNewBeam = true,
				BeamDuration = 3.0999999999999996,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}