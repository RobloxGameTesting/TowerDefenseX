local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Vulnerable,
	Percentage = 3,
	Time = 10,
	IsDebuff = true,
	DamagePerSecond = 1,
	CustomVisualEffectName = Enums.VisualEffects.DamageDebuff
}