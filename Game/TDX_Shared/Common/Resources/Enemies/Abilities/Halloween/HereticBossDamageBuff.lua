local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 25,
	Cooldown = 25,
	Animated = true,
	AnimationName = "BossDamageBuff",
	Delay = 0.5,
	ExecutionTime = 2.0999999999999996,
	EffectParentInstanceNames = { "Staff>StaffSymbol>DamageBuffSFX", "Staff>StaffSymbol>DamageBuffVFX" },
	EffectsStopDelay = 1.333,
	EnemyToEnemyRadiusEffectData = {
		NoAffectSelf = true,
		BossOrMiniBossOnly = true,
		MinimumTargetPrerequisites = { NoTargetSelf = true, BossOrMiniBossOnly = true },
		EnemyBuffNames = { Enums.EnemyBuffs.HereticBossDamageBuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Staff>StaffSymbol>DamageBuffBeam",
				MakeNewBeam = true,
				BeamDuration = 0.833,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}