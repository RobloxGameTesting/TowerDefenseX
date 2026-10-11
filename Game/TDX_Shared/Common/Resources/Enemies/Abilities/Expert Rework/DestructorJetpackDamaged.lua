local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 40,
	Animated = true,
	Delay = 0.95,
	ExecutionTime = 6.2,
	AnimationName = "JetpackDamaged",
	FaceTarget = true,
	ForceFaceOverideTime = 0.6,
	ForceFaceOverideTimeInitial = 0.8,
	ParallelAbilityNames = { Enums.EnemyAbilities.DestructorJetpackDamaged_Land },
	PrerequisiteAbilityName = Enums.EnemyAbilities.DestructorRage,
	EffectParentInstanceNames = { "Jetpack", "JetpackAbilitySFX" },
	EffectsStartDelay = 0,
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 30, MinimumPathStudsLeft = 35 },
		TweenToGoal = true,
		TweenTime = 3.5169999999999995,
		TweenStartDelay = 0.95
	},
	SetInvulnerableForTime = 3.5169999999999995
}