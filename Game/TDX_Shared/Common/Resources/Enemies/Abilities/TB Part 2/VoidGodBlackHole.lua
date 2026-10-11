local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 60,
	Cooldown = 120,
	Animated = true,
	AnimationName = "BlackHole",
	AutoHandleEffects = true,
	Delay = 2.9,
	ExecutionTime = 12.7,
	GlobalTowerBuffData = {
		TowerBuffNames = { Enums.TowerBuffs.VoidGodBlackHoleDebuff }
	},
	TimeManipulationData = { SpeedMultiplier = 0.1, Duration = 8 }
}