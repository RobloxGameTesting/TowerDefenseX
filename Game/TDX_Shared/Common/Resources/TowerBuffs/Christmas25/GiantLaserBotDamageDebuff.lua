local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Damage,
	Percentage = 0.2,
	Time = 2,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.DamageDebuff
}