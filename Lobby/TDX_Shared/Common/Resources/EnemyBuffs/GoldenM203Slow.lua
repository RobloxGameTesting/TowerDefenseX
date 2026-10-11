local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.MovementSpeed,
	Percentage = 0.3,
	BossPercentage = 0,
	Time = 4,
	IsDebuff = true,
	NoVisualEffect = true
}