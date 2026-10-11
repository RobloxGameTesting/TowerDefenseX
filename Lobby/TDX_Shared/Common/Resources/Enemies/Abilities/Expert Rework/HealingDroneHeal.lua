local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	StartingCooldownVariance = 1,
	Cooldown = 0.1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	ForcePlayEffectsOnAbilityUsedOnServer = true,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EffectParentInstanceNames = { "Turret>Gun>Gun>HealSFX", "Turret>Gun>Gun>HealVFX" },
	EffectsStopDelay = 0.3,
	EnemyToEnemyRangedData = {
		Range = 20,
		QueryType = "Strongest",
		BossOrMiniBossOnly = true,
		HealData = { HealAmount = 500 },
		HealDataTargetMustBeDamaged = true
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Turret>Gun>Gun>HealBeam",
				MakeNewBeam = false,
				BeamDuration = 0.3,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		},
		TryRestartExistingBeam = true
	}
}