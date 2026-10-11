local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.Heal,
	Percentage = 0.5,
	Time = 0.25,
	HealPerSecond = 1400000,
	IsDebuff = false,
	CustomVisualEffectName = Enums.VisualEffects.BossHeal
}