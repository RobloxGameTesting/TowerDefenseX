local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Damage2,
	Percentage = 0.3,
	Time = 20,
	IsDebuff = false,
	EffectPositionAtFeet = true,
	CustomVisualEffectName = Enums.VisualEffects.CommanderBuff
}