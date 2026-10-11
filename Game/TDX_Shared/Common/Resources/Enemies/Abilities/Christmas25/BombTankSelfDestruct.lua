local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = true,
	Delay = 10 / 3,
	ExecutionTime = 3.333333333333333,
	AnimationName = "Explode",
	MaximumUses = 1,
	TriggeredAtPathPercentage = 0.98,
	Kamikaze = true,
	DamageBaseData = { InstantLoss = true }
}