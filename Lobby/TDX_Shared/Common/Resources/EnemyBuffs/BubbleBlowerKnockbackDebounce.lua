local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.Knockback,
	Percentage = 0,
	Time = 2.25,
	NoReactivateIfAlreadyActive = true,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.BubbleBlowerDebuff
}