local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.Damage,
	Percentage = 0.25,
	Time = 5,
	IsDebuff = false,
	CustomVisualEffectName = Enums.VisualEffects.HereticBossDamageBuff
}