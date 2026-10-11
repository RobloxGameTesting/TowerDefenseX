local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.TakeDamage,
	Percentage = 0.5,
	Time = 1.7999999999999998,
	DamagePerSecond = 25000 / 9,
	IsDebuff = true,
	NoVisualEffect = true
}