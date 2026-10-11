local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Carcin = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Carcin"))
return (TableUtilities.Extend(Carcin, {
	OverrideCharacterModelName = "Carcin",
	OverrideDisplayName = "Carcin",
	IsPVP = true,
	SendCost = 2100,
	UnlockWave = 24,
	BuildDuration = 4.2,
	SendEco = 40
}))