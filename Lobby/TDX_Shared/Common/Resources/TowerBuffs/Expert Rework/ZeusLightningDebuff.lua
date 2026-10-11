local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Damage,
	Percentage = 0,
	Time = 0.6669999999999999,
	DamagePerSecond = 600,
	IsDebuff = true,
	NoVisualEffect = true
}