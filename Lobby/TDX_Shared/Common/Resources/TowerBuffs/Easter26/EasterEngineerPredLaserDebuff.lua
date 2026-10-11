local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.LaserDamage,
	Percentage = 0.5,
	Time = 1,
	DamagePerSecond = 5000,
	IsDebuff = true,
	NoVisualEffect = true
}