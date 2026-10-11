local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.Heal,
	Percentage = 0,
	Time = 0.1,
	NotCountedAsFriendlyBuff = true,
	CustomVisualEffectName = Enums.VisualEffects.HealBuffQuick
}