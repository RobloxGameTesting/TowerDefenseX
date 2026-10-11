local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Damage,
	Percentage = 0,
	Time = 3,
	DamagePerSecond = 2500 / 3,
	DamagePercentagePerSecond = 1 / 6,
	IsDebuff = true,
	NoVisualEffect = true
}