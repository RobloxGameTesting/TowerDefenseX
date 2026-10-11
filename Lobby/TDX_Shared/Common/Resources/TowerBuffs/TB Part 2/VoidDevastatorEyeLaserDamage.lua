local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.TakeDamage,
	Percentage = 1,
	Time = 2.4499999999999997,
	DamagePerSecond = 60000,
	IsDebuff = true,
	NoVisualEffect = true
}