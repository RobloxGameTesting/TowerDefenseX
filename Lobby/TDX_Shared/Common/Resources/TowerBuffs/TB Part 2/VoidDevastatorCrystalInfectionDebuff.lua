local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Firerate,
	Percentage = 0.5,
	Time = 12.866999999999999,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.VoidCrystalDebuff
}