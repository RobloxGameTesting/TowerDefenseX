local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 2,
	Cooldown = 17,
	Animated = true,
	Delay = 0,
	ExecutionTime = 101 / 15,
	ContinueMovingWhileUsing = true,
	AnimationName = "Shield Charge",
	InstantPlayEffectParentInstanceNames = {
		"FXPart>ShieldChargeIntroSFX",
		"FXPart>ShieldChargeLoopSFX",
		"FXPart>ShieldChargeEndSFX"
	},
	TakeNoDamageTime = 6.25,
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{
				Time = 1 / 3,
				MovementSpeed = 10
			},
			{ Time = 6.25, ResetToDefault = true }
		}
	}
}