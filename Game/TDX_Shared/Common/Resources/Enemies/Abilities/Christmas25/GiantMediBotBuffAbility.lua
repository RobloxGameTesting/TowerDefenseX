local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	AnimationName = "Uber",
	ForcePlayAnimationOnClientside = true,
	NoRestartAnimationIfAlreadyPlaying = true,
	StopAnimationDelay = 0.5,
	Delay = 0,
	ExecutionTime = 6,
	ContinueMovingWhileUsing = true,
	ForcePlayEffectsOnAbilityUsedOnServer = true,
	MaxStudsRemainingCanUse = 35,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EnemyToEnemyRangedData = {
		Range = 20,
		QueryType = "Strongest",
		CustomFilter = function(p)
			return p.IsGiantRobot
		end,
		EnemyBuffNames = { Enums.EnemyBuffs.GiantMediBotUberBuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Turret>Gun>Weapon>BeamUber",
				MakeNewBeam = true,
				BeamDuration = 6,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		},
		TryRestartExistingBeam = true
	}
}