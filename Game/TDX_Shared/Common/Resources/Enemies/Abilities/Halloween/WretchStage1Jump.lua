local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 0.77,
	ExecutionTime = 2.917,
	AnimationName = "Stage1Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.6,
	ForceFaceOverideTimeInitial = 1.3,
	ParallelAbilityNames = { Enums.EnemyAbilities.WretchStage1JumpDamage },
	EffectParentInstanceNames = { "JumpVFX", "LandVFX" },
	EnemyTeleportData = {
		ForcedPathIndexData = { PathIndex = 26, MinimumPathPercentageDelta = 0.3 },
		TweenToGoal = true,
		TweenTime = 1.2799999999999998,
		TweenStartDelay = 0.77
	},
	SetInvulnerableForTime = 1.2799999999999998
}