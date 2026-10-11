local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local EradB = require(script.Parent.Parent:WaitForChild("Tutorial"):WaitForChild("Erad-B"))
return (TableUtilities.Extend(EradB, {
	OverrideCharacterModelName = "Erad-B",
	OverrideDisplayName = "Erad-B",
	OverrideCustomCodeName = "Erad-B",
	IsPVP = true,
	SendCost = 19000,
	UnlockWave = 21,
	BuildDuration = 15,
	SendEco = -250
}))