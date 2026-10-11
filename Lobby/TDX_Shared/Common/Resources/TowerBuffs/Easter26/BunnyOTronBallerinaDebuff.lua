local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.LaserDamage,
	Percentage = 0.5,
	Time = 3.8,
	DamagePerSecond = 12500 / 19,
	IsDebuff = true,
	NoVisualEffect = true
}