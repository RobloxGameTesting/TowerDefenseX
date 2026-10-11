local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Gas,
	Percentage = 0.5,
	Time = 10,
	DamagePerSecond = 35,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.GasDebuff
}