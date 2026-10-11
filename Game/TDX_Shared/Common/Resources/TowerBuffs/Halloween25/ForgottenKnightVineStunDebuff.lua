local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Stun,
	IgnoreStunImmunity = true,
	IsDebuff = true,
	Percentage = 1,
	Time = 3.5,
	CustomVisualEffectName = Enums.VisualEffects.ForgottenKnightVineStunDebuff
}