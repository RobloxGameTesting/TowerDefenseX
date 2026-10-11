local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.LaserDamage,
	Percentage = 0.5,
	Time = 0.6000000000000001,
	DamagePerSecond = 66666.66666666666,
	IsDebuff = true,
	NoVisualEffect = true
}