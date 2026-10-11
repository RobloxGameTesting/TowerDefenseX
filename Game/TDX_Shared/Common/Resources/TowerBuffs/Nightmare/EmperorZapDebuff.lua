local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Range,
	Percentage = 0.6,
	Time = 9.350000000000001,
	IsDebuff = true,
	EffectPositionOnHead = true
}