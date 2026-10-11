local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 70,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 3.8,
	AnimationName = "Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.3,
	ForceFaceOverideTimeInitial = 1.2,
	ParallelAbilityNames = { Enums.EnemyAbilities.SlimeKingPhase2Jump_Land },
	EffectParentInstanceNames = { "Jump>Root>Start", "Jump>Root>Land" },
	InstantPlayEffectParentInstanceNames = { "Root>SFX>Jump" },
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 35, MinimumPathStudsLeft = 40 },
		TweenToGoal = true,
		TweenTime = 1.35,
		TweenStartDelay = 0.5
	},
	SetInvulnerableForTime = 1.35
}