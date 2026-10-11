local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.Heal,
	Percentage = 0,
	Time = 5,
	NoReactivateIfAlreadyActive = true,
	HealPercentPerSecond = 0.02,
	IsDebuff = false,
	CustomVisualEffectName = Enums.VisualEffects.GenericHealBuff,
	NoReactivateVisualEffect = true
}