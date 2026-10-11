local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local ResurrectedSlammer = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("Resurrected Slammer"))
return (TableUtilities.Extend(ResurrectedSlammer, {
	OverrideCharacterModelName = "Resurrected Slammer",
	OverrideDisplayName = "Resurrected Slammer",
	IsPVP = true,
	SendCost = 15000,
	UnlockWave = 24,
	BuildDuration = 7,
	SendEco = 215,
	BodyHeat = 2500,
	BodyHeatRegenerationRate = 300
}))