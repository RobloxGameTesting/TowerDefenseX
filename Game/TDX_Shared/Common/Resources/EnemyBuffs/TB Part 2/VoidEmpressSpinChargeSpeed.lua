local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.MovementSpeed,
	Percentage = 0.75,
	Time = 383 / 60,
	NoReactivateIfAlreadyActive = true,
	IsDebuff = false,
	NoVisualEffect = true
}