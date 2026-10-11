local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = true,
	Delay = 0,
	ExecutionTime = 1.7466666666666668,
	AnimationName = "Transition",
	EffectParentInstanceNames = { "Transition>FXPart" },
	EffectsStartDelay = 0,
	MaximumUses = 1,
	MovementSpeedIncrease = 5,
	ReplaceAnimationMap = { Move = "Run" },
	TriggeredAtHealthPercentage = 0.75
}