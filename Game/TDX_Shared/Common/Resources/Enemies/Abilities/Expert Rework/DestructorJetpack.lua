local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 55,
	Animated = true,
	Delay = 1.3,
	ExecutionTime = 6.567,
	AnimationName = "Jetpack",
	FaceTarget = true,
	ForceFaceOverideTime = 0.6,
	ForceFaceOverideTimeInitial = 1.2,
	ParallelAbilityNames = { Enums.EnemyAbilities.DestructorJetpack_Land },
	EffectParentInstanceNames = { "Jetpack", "JetpackAbilitySFX" },
	EffectsStartDelay = 0,
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 30, MinimumPathStudsLeft = 35 },
		TweenToGoal = true,
		TweenTime = 3.5170000000000003,
		TweenStartDelay = 1.3
	},
	SetInvulnerableForTime = 3.5170000000000003
}