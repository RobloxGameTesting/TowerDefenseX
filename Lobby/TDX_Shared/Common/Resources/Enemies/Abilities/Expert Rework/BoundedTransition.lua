local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 1,
	Animated = true,
	Delay = 0,
	ExecutionTime = 1.3,
	AnimationName = "Transition",
	EffectParentInstanceNames = { "Transition" },
	EffectsStartDelay = 0.7,
	MaximumUses = 1,
	MovementSpeedIncrease = 7.3,
	ReplaceAnimationMap = { Move = "Run" }
}