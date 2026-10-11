local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Firerate,
	Percentage = 0.65,
	Time = 10,
	DamagePerSecond = 50,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.GasDebuff
}