local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	StartingCooldownVariance = 2,
	Cooldown = 5,
	CooldownVariance = 2,
	Animated = true,
	Delay = 0.167,
	ExecutionTime = 1.25,
	ContinueMovingWhileUsing = true,
	AnimationName = "Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.2,
	ForceFaceOverideTimeInitial = 0.12,
	EffectParentInstanceNames = { "Jump" },
	MovementSpeedData = {
		StartTime = 0.167,
		TimingData = {
			{ Time = 0.167, MovementSpeed = 0 },
			{ Time = 1.2, ResetToDefault = true }
		}
	},
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 23, MinimumPathStudsLeft = 28 },
		RemoveForceFaceOnStop = true,
		TweenToGoal = true,
		TweenTime = 1.033,
		TweenStartDelay = 0.167
	},
	SetInvulnerableForTime = 1.033
}