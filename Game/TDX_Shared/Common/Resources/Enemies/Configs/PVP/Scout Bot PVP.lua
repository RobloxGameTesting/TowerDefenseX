local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local ScoutBot = require(script.Parent.Parent:WaitForChild("Christmas25"):WaitForChild("Scout Bot"))
return (TableUtilities.Extend(ScoutBot, {
	OverrideCharacterModelName = "Scout Bot",
	OverrideDisplayName = "Scout Bot",
	IsPVP = true,
	SendCost = 875,
	UnlockWave = 17,
	BuildDuration = 3.5,
	SendEco = 35,
	BodyHeat = 900,
	BodyHeatRegenerationRate = 90
}))