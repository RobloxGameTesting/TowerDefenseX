local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 3,
	StartingCooldownVariance = 2,
	Cooldown = 17,
	CooldownVariance = 2,
	Animated = true,
	Delay = 7 / 60,
	ExecutionTime = 83 / 60,
	ContinueMovingWhileUsing = true,
	AnimationName = "Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.2,
	ForceFaceOverideTimeInitial = 0.12,
	EffectParentInstanceNames = { "Jump" },
	MovementSpeedData = {
		StartTime = 7 / 60,
		TimingData = {
			{
				Time = 7 / 60,
				MovementSpeed = 0
			},
			{ Time = 1.35, ResetToDefault = true }
		}
	},
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 32, MinimumPathStudsLeft = 35 },
		RemoveForceFaceOnStop = true,
		TweenToGoal = true,
		TweenTime = 74 / 60,
		TweenStartDelay = 7 / 60
	},
	SetInvulnerableForTime = 74 / 60
}