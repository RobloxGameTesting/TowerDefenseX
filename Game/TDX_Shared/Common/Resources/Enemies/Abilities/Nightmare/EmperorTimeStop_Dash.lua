local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	DoNotTryToUse = true,
	MovementSpeedData = {
		StartTime = 0,
		StopTime = 13.75,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 },
			{ Time = 11.5, MovementSpeed = 2 },
			{ Time = 11.55, MovementSpeed = 4 },
			{ Time = 11.6, MovementSpeed = 7 },
			{ Time = 11.65, MovementSpeed = 11 },
			{ Time = 12.05, MovementSpeed = 18 },
			{ Time = 12.9, MovementSpeed = 8 },
			{ Time = 13.5, MovementSpeed = 3 },
			{ Time = 13.75, MovementSpeed = 1.5 }
		}
	}
}