local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 6.5,
	StartingCooldownVariance = 1.5,
	Cooldown = 1e999,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	MaximumUses = 1,
	MovementSpeedIncrease = -2.4,
	ReplaceAnimationMap = { Move = "Jog" }
}