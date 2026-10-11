local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.TakeDamage,
	Percentage = 0,
	Time = 2.6999999999999997,
	DamagePerSecond = 20000 / 27,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.DestructorAreaShockDebuff
}