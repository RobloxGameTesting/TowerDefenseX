local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Range,
	Percentage = 0.95,
	Time = 15,
	DamagePerSecond = 15,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.SmokeDebuff
}