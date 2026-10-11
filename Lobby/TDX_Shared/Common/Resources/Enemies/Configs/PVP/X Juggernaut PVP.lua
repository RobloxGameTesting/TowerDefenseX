local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local XJuggernaut = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("X Juggernaut"))
return (TableUtilities.Extend(XJuggernaut, {
	OverrideCharacterModelName = "X Juggernaut",
	OverrideDisplayName = "X Juggernaut",
	IsPVP = true,
	SendCost = 22000,
	UnlockWave = 31,
	BuildDuration = 5,
	SendEco = -200,
	BodyHeat = 3000,
	BodyHeatRegenerationRate = 320
}))