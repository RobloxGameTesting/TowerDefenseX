local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.DamageResistance,
	Percentage = 0.2,
	BossPercentage = 0.1,
	Time = 6,
	IsDebuff = true,
	NoVisualEffect = true
}