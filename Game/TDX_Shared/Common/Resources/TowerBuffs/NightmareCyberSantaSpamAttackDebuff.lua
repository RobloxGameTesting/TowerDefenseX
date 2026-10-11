local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.EradicatorMK2Minigun,
	Percentage = 0,
	Time = 0.1,
	DamagePerSecond = 1900,
	IsDebuff = true
}