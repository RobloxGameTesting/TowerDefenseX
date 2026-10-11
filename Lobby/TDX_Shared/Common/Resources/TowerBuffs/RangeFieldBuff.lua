local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Range,
	Percentage = 0.5,
	Time = 0.1,
	IsDebuff = false,
	NotCountedAsFriendlyBuff = true,
	NoVisualEffect = true
}