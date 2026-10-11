local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.7,
	AnimationName = "Jump",
	ContinueMovingWhileUsing = true,
	MaximumUses = 1,
	MovementSpeedIncrease = 3,
	TriggeredAtHealthPercentage = 0.2,
	TakeNoDamageTime = 1,
	Kamikaze = true
}