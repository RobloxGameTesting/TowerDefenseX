local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 1,
	ExecutionTime = 5.683,
	ContinueMovingWhileUsing = true,
	AnimationName = "ShieldStance",
	EffectParentInstanceNames = { "ShieldStance" },
	EffectsStopDelay = 5,
	HealData = { ShieldGain = 6500, ShieldCap = 18000 },
	TakeNoDamageTime = 4,
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 },
			{ Time = 5.05, ResetToDefault = true }
		}
	}
}