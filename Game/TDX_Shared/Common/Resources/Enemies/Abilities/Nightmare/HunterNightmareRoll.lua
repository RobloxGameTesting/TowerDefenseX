local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = true,
	Delay = 0,
	ExecutionTime = 3.2,
	ContinueMovingWhileUsing = true,
	AnimationName = "Roll",
	EffectParentInstanceNames = { "RollFX" },
	InstantPlayEffectParentInstanceNames = {},
	MovementSpeedData = {
		StartTime = 0,
		StopTime = 2.8,
		TimingData = {
			{ Time = 0, MovementSpeed = 2.2 },
			{ Time = 0.5, MovementSpeed = 8 }
		}
	}
}