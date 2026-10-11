local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Burn,
	Percentage = 0.5,
	Time = 3,
	DamagePerSecond = 200,
	IsDebuff = true,
	NoVisualEffect = true
}