local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 9,
	Cooldown = 0,
	Delay = 0,
	ExecutionTime = 9999999,
	Animated = true,
	AnimationName = "ChargeStart",
	ContinueMovingWhileUsing = true,
	EffectParentInstanceNames = { "Root>ChargeFX" },
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 },
			{ Time = 0.8, MovementSpeed = 7 }
		}
	}
}