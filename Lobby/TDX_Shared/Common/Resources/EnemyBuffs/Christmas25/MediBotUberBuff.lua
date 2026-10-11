local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.Uber,
	Percentage = 1,
	Time = 5,
	IsDebuff = false,
	EffectPositionAtFeet = true,
	CustomVisualEffectName = Enums.VisualEffects.UberBuff
}