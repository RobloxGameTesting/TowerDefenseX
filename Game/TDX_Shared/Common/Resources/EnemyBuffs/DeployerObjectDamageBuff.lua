local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.Damage,
	Percentage = 3,
	Time = 10,
	NoReactivateIfAlreadyActive = true,
	IsDebuff = false,
	CustomVisualEffectName = Enums.VisualEffects.GenericDamageBuff,
	NoReactivateVisualEffect = true
}