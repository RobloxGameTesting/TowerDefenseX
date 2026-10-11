local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	StartingCooldownVariance = 2,
	Cooldown = 8,
	CooldownVariance = 2,
	Animated = true,
	Delay = 1 / 6,
	ExecutionTime = 0.9666666666666668,
	ContinueMovingWhileUsing = true,
	AnimationName = "Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.2,
	ForceFaceOverideTimeInitial = 0.12,
	MovementSpeedData = {
		StartTime = 1 / 6,
		TimingData = {
			{
				Time = 1 / 6,
				MovementSpeed = 0
			},
			{ Time = 0.9, ResetToDefault = true }
		}
	},
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 23, MinimumPathStudsLeft = 28 },
		RemoveForceFaceOnStop = true,
		TweenToGoal = true,
		TweenTime = 0.7333333333333334,
		TweenStartDelay = 1 / 6
	},
	SetInvulnerableForTime = 0.7333333333333334
}