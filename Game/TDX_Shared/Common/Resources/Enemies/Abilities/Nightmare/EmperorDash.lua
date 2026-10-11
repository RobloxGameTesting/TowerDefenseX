local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 40,
	Cooldown = 60,
	Animated = true,
	Delay = 0,
	ExecutionTime = 5.933,
	ContinueMovingWhileUsing = true,
	AnimationName = "Dash",
	EffectParentInstanceNames = { "Dash" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Dash" },
	MovementSpeedData = {
		StartTime = 0,
		StopTime = 13.75,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 },
			{ Time = 2.7, MovementSpeed = 30 },
			{ Time = 4.15, MovementSpeed = 16 },
			{ Time = 4.35, MovementSpeed = 12 },
			{ Time = 4.55, MovementSpeed = 8.5 },
			{ Time = 4.75, MovementSpeed = 6.5 },
			{ Time = 4.95, MovementSpeed = 4 },
			{ Time = 5.15, MovementSpeed = 2 },
			{ Time = 5.35, MovementSpeed = 1.5 }
		}
	}
}