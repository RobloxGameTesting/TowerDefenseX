local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 3.7329999999999997,
	AnimationName = "Stage2Burrow",
	ParallelAbilityNames = { Enums.EnemyAbilities.WretchStage2UnburrowDamage },
	PrerequisiteAbilityName = Enums.EnemyAbilities.WretchTransition,
	EffectParentInstanceNames = { "BurrowVFX", "BurrowTailVFX", "UnburrowVFX" },
	EnemyTeleportData = {
		ForcedPathIndexData = { PathIndex = 27, MinimumPathPercentageDelta = 0.15 },
		TweenToGoal = true,
		TweenTime = 0.1,
		TweenStartDelay = 2.3
	},
	SetInvulnerableForTime = 2.1
}