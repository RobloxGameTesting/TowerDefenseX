local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 1e999,
	Cooldown = 1e999,
	Animated = true,
	Delay = 7 / 6,
	ExecutionTime = 7 / 6,
	AnimationName = "Rebirth",
	SetAirUnit = true,
	ReplaceAnimationMap = { Move = "Fly" }
}