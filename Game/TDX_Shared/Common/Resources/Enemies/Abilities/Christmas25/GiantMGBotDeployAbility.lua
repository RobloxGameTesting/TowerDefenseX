local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(ReplicatedStorage.TDX_Shared.Common.QueryType)
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 1e999,
	Animated = true,
	Delay = 0,
	ExecutionTime = 1.58,
	AnimationName = "Deploy",
	EffectParentInstanceNames = { "DeployVFXPart" },
	MaximumUses = 1,
	MovementSpeedData = {
		StartTime = 0,
		StopTime = 1e999,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 }
		}
	},
	ReplaceAnimationMap = { Move = "Idle" },
	TriggerRangedQueryData = {
		QueryClass = Enums.EntityClass.PathEntity,
		QueryType = Enums.QueryType.Closest,
		Range = 40
	}
}