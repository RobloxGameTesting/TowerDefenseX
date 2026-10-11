local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Pilot = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Pilot"))
return (TableUtilities.Extend(Pilot, {
	OverrideCharacterModelName = "Pilot",
	OverrideDisplayName = "Pilot",
	OverrideCustomCodeName = "Pilot",
	IsPVP = true,
	SendCost = 3000,
	UnlockWave = 31,
	BuildDuration = 2,
	SendEco = -100,
	Speed = 18
}))