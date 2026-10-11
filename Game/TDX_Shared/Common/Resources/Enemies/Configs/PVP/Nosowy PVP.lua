local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Nosowy = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Nosowy"))
return (TableUtilities.Extend(Nosowy, {
	OverrideCharacterModelName = "Nosowy",
	OverrideDisplayName = "Nosowy",
	IsPVP = true,
	SendCost = 900,
	UnlockWave = 16,
	BuildDuration = 3.8,
	SendEco = 33
}))