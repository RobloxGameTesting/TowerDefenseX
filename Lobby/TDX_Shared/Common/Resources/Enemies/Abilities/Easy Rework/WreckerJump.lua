local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 3,
	Cooldown = 25,
	CooldownVariance = 6,
	Animated = true,
	Delay = 0.05,
	ExecutionTime = 2,
	ContinueMovingWhileUsing = true,
	AnimationName = "Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.2,
	ForceFaceOverideTimeInitial = 0.12,
	EffectParentInstanceNames = { "GroundFX" },
	EffectsStartDelay = 1.2,
	EffectsStopDelay = 3.2,
	InstantPlayEffectParentInstanceNames = { "Root>JumpSFX" },
	MovementSpeedData = {
		StartTime = 0.05,
		TimingData = {
			{ Time = 0.05, MovementSpeed = 0 },
			{ Time = 1.2, ResetToDefault = true }
		}
	},
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 23, MinimumPathStudsLeft = 28 },
		RemoveForceFaceOnStop = true,
		TweenToGoal = true,
		TweenTime = 1.15,
		TweenStartDelay = 0.05,
		JumpHeight = 8
	},
	SetInvulnerableForTime = 1.15
}