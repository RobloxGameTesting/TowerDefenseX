local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 29,
	Animated = true,
	Delay = 0,
	ExecutionTime = 5.75,
	ContinueMovingWhileUsing = true,
	AnimationName = "ShieldRush",
	EffectParentInstanceNames = { "ShieldRush" },
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 },
			{ Time = 0.85, MovementSpeed = 10 },
			{ Time = 4.2, MovementSpeed = 0 }
		}
	}
}