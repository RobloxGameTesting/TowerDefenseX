local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Burn,
	Percentage = 0.5,
	Time = 2.85,
	DamagePerSecond = 160000 / 19,
	IsDebuff = true,
	NoVisualEffect = true
}