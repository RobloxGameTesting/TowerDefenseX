local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 3,
	Cooldown = 15,
	Animated = true,
	Delay = 0,
	ExecutionTime = 23 / 3,
	ContinueMovingWhileUsing = true,
	AnimationName = "ChargeStart",
	ForcePlayAnimationOnClientside = true,
	NoRestartAnimationIfAlreadyPlaying = false,
	GainDamageReductionData = {
		Amount = 0.5,
		Time = 23 / 3
	},
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{ Time = 0, MovementSpeed = 0.4 },
			{
				Time = 61 / 60,
				MovementSpeed = 7
			},
			{
				Time = 23 / 3,
				ResetToDefault = true
			}
		}
	}
}