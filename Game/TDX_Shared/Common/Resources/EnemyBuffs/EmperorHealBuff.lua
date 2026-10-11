local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.Heal,
	Percentage = 0.5,
	Time = 9.35,
	HealPerSecond = 1200000 / 187,
	IsDebuff = false,
	NoVisualEffect = true
}