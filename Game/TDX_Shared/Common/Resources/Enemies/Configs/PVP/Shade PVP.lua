local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Shade = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Shade"))
return (TableUtilities.Extend(Shade, {
	OverrideCharacterModelName = "Shade",
	OverrideDisplayName = "Shade",
	IsPVP = true,
	SendCost = 560,
	UnlockWave = 16,
	BuildDuration = 2.5,
	SendEco = 9
}))