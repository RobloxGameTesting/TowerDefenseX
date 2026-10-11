local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Uber,
	Percentage = 1,
	Time = 12,
	IsDebuff = false,
	CustomVisualEffectName = Enums.VisualEffects.CombatDroneShield,
	NotCountedAsFriendlyBuff = true
}