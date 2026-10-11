local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Firerate,
	Percentage = 0.25,
	Time = 5,
	IsDebuff = true,
	EffectPositionOnHead = true,
	CustomVisualEffectName = Enums.VisualEffects.ToxicDebuff
}