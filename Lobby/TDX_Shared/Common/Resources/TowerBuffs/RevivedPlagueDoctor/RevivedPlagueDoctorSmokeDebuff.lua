local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Firerate,
	Percentage = 0.4,
	Time = 2,
	DamagePerSecond = 2,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.SmokeDebuff
}