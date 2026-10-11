local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.EnemyBuffTypes.MovementSpeed,
	Percentage = 0.6,
	Time = 5,
	NoReactivateIfAlreadyActive = true,
	IsDebuff = false,
	CustomVisualEffectName = Enums.VisualEffects.SlimeAbsorberBuff,
	NoReactivateVisualEffect = true
}