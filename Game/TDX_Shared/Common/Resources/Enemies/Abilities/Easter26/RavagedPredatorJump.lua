local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	StartingCooldownVariance = 2,
	Cooldown = 30,
	CooldownVariance = 6,
	Animated = true,
	Delay = 38 / 60,
	ExecutionTime = 149 / 60,
	ContinueMovingWhileUsing = true,
	AnimationName = "Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.2,
	ForceFaceOverideTimeInitial = 0.12,
	ParallelAbilityNames = { Enums.EnemyAbilities.RavagedPredatorJump_Land },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Jump" },
	EffectParentInstanceNames = { "GroundFX" },
	EffectsStartDelay = 1.95,
	EffectsStopDelay = 3.95,
	MovementSpeedData = {
		StartTime = 38 / 60,
		TimingData = {
			{
				Time = 38 / 60,
				MovementSpeed = 0
			},
			{ Time = 1.95, ResetToDefault = true }
		}
	},
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 27, MinimumPathStudsLeft = 32 },
		RemoveForceFaceOnStop = true,
		TweenToGoal = true,
		TweenTime = 79 / 60,
		TweenStartDelay = 38 / 60,
		JumpHeight = 10
	},
	SetInvulnerableForTime = 79 / 60
}