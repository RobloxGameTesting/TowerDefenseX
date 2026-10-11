local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.Heal,
	Percentage = 0.5,
	Time = 5.45,
	HealPerSecond = 12500,
	IsDebuff = false,
	NoVisualEffect = true
}