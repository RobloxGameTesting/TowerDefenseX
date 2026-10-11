local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 0.1,
	Animated = true,
	AnimationName = "Heal",
	ForcePlayAnimationOnClientside = true,
	NoRestartAnimationIfAlreadyPlaying = true,
	StopAnimationDelay = 0.5,
	Delay = 0,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	ForcePlayEffectsOnAbilityUsedOnServer = true,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EnemyToEnemyRangedData = {
		Range = 20,
		QueryType = "Strongest",
		HealData = { HealAmount = 15 },
		HealDataTargetMustBeDamaged = true
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Turret>Gun>Main>Beam",
				MakeNewBeam = true,
				BeamDuration = 0.25,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		},
		TryRestartExistingBeam = true
	}
}