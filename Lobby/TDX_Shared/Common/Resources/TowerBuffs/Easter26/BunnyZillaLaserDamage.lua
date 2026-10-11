local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.TakeDamage,
	Percentage = 0.5,
	Time = 8.216666666666665,
	DamagePerSecond = 973.6308316430022,
	IsDebuff = true,
	NoVisualEffect = true
}