local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.TakeDamage,
	Percentage = 0.5,
	Time = 4.9670000000000005,
	DamagePerSecond = 201.328769881216,
	IsDebuff = true,
	NoVisualEffect = true
}