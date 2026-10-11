local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Stun,
	Percentage = 1,
	IgnoreStunImmunity = true,
	Time = 0.8,
	IsDebuff = true,
	EffectPositionOnHead = true
}