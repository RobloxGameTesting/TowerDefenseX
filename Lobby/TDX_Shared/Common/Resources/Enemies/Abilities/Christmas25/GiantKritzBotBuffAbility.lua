local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 7,
	Cooldown = 25,
	Animated = true,
	AnimationName = "Uber",
	ForcePlayAnimationOnClientside = true,
	NoRestartAnimationIfAlreadyPlaying = true,
	StopAnimationDelay = 0.5,
	Delay = 0,
	ExecutionTime = 5,
	ContinueMovingWhileUsing = true,
	ForcePlayEffectsOnAbilityUsedOnServer = true,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EnemyToEnemyRangedData = {
		Range = 30,
		QueryType = "Strongest",
		CustomFilter = function(p)
			return p.IsGiantRobot
		end,
		EnemyBuffNames = { Enums.EnemyBuffs.GiantKritzBotDamageBuff }
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Turret>Gun>Weapon>BeamUber",
				MakeNewBeam = true,
				BeamDuration = 5,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		},
		TryRestartExistingBeam = true
	}
}