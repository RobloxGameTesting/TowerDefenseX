local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Burn,
	Percentage = 0,
	Time = 9,
	DamagePercentagePerSecond = 0.05,
	IsDebuff = true,
	IsFireEffect = true,
	NoVisualEffect = true
}