local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = true,
	Delay = 0,
	ExecutionTime = 1.2466666666666668,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "HeadFX" },
	EffectsStartDelay = 0,
	MaximumUses = 1,
	MovementSpeedIncrease = 5,
	ReplaceAnimationMap = { Move = "Fly" },
	SetAirUnit = true,
	TriggeredAtHealthPercentage = 0.7
}