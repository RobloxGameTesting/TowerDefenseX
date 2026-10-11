local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Burn,
	Percentage = 1,
	Time = 1,
	DamagePerSecond = 250,
	IsDebuff = true,
	NoVisualEffect = true
}