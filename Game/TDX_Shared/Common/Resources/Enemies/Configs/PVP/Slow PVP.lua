local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local TB2Slow = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("TB2 Slow"))
return (TableUtilities.Extend(TB2Slow, {
	OverrideCharacterModelName = "TB2 Slow",
	Health = 70,
	Shield = 25,
	IsPVP = true,
	SendCost = 130,
	UnlockWave = 7,
	BuildDuration = 3.8,
	SendEco = 14
}))