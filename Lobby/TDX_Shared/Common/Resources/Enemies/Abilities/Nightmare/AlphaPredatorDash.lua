local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 80,
	Animated = true,
	Delay = 1.033,
	ExecutionTime = 4.8,
	AnimationName = "Dash",
	FaceTarget = true,
	ForceFaceOverideTime = 0.6,
	ForceFaceOverideTimeInitial = 1.2,
	ParallelAbilityNames = { Enums.EnemyAbilities.AlphaPredatorDash_Land },
	EffectParentInstanceNames = { "Dash" },
	EffectsStartDelay = 0,
	InstantPlayEffectParentInstanceNames = { "Root>SFX>Dash" },
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 30, MinimumPathStudsLeft = 35 },
		TweenToGoal = true,
		TweenTime = 2.484,
		TweenStartDelay = 1.033
	},
	SetInvulnerableForTime = 2.484
}