local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Stun,
	Percentage = 1,
	Time = 6,
	IsDebuff = true,
	EffectPositionOnHead = true,
	IgnoreStunImmunity = true
}