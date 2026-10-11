local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Uber,
	Percentage = 1,
	Time = 1e999,
	InstantHealAmount = 1000,
	HealPerSecond = 500,
	IsDebuff = false,
	EffectPositionAtFeet = true,
	CustomVisualEffectName = Enums.VisualEffects.UberBuff,
	DependentOnAbilityBeingActive = true,
	NotCountedAsFriendlyBuff = true
}