local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 0.8,
	ExecutionTime = 3.5,
	AnimationName = "Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.6,
	ForceFaceOverideTimeInitial = 1.2,
	ParallelAbilityNames = { Enums.EnemyAbilities.JagerJump_ShootGround },
	EffectParentInstanceNames = { "Jump" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Jump" },
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 15, MinimumPathStudsLeft = 20 },
		TweenToGoal = true,
		TweenTime = 0.8,
		TweenStartDelay = 0.8
	},
	SetInvulnerableForTime = 0.8
}