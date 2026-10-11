local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 389 / 300,
	AnimationName = "Boost",
	EffectParentInstanceNames = { "Transition>FXPart" },
	MaximumUses = 1,
	MovementSpeedIncrease = 6.5,
	HealData = { ShieldGainPercentageOfTargetMaxHealth = 2 },
	ReplaceAnimationMap = { Move = "RunBoosted" },
	TriggeredAtHealthPercentage = 0.6
}