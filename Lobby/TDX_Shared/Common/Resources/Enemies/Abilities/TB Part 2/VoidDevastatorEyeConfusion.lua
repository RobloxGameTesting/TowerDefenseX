local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToPlayerRangedData = {
	TargetRandomPlayerCount = 1,
	PlayerEffectName = Enums.PlayerEffects.VoidDevastatorEyeConfusion,
	Duration = 2.4499999999999997,
	KillTargetPlayers = true,
	KillTargetPlayersDuration = 1.2,
	BeamEffectHandlingData = {
		{
			BeamParentInstanceName = "EyeConfusionBeam>BeamOrigin>Beam",
			MakeNewBeam = true,
			BeamDuration = 2.4499999999999997,
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		}
	}
}
return {
	StartingCooldown = 15,
	Cooldown = 40,
	Animated = true,
	AnimationName = "EyeConfusion",
	AutoHandleEffects = true,
	Delay = 1.35,
	ExecutionTime = 4.332999999999999,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidDevastatorAwakening,
	FaceTarget = true,
	ForceFaceOverideTime = 0.9,
	EnemyToPlayerRangedData = enemyToPlayerRangedData
}