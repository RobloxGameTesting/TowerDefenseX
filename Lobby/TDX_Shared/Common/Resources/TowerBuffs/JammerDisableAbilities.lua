local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TowerBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Type = Enums.TowerBuffTypes.DisableAbilities,
	Percentage = 0.5,
	Time = 0.2,
	IsDebuff = true,
	CustomVisualEffectName = Enums.VisualEffects.EMPDebuff
}