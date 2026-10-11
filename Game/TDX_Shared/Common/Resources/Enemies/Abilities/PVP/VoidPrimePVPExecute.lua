local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 17,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidPrimePVPRage,
	Animated = true,
	Delay = 1.1,
	ExecutionTime = 89 / 30,
	AnimationName = "DualBladeStab",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { InstantKill = true, InstantKillType = "Void" },
			Range = 12,
			TargetMostExpensiveTower = true,
			EffectParentInstanceName = "DualBladeStabVFX",
			EffectsStartDelay = 1.1,
			EffectsStopDelay = 2.1
		}
	},
	InstantPlayEffectParentInstanceNames = { "DualBladeStabSFX" },
	EffectParentInstanceNames = { "StabChargeVFX1", "StabChargeVFX2" },
	EffectsStartDelay = 0.5,
	EffectsStopDelay = 1
}