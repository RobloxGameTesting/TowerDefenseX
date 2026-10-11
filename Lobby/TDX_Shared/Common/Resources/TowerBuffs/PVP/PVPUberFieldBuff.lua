local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Uber,
	Percentage = 1,
	Time = 0.1,
	HealPerSecond = 100,
	IsDebuff = false,
	EffectPositionAtFeet = true,
	CustomVisualEffectName = Enums.VisualEffects.UberBuff,
	NotCountedAsFriendlyBuff = true
}