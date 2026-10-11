local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Buzzard = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Buzzard"))
return (TableUtilities.Extend(Buzzard, {
	OverrideCharacterModelName = "Buzzard",
	OverrideDisplayName = "Buzzard",
	IsPVP = true,
	SendCost = 300,
	UnlockWave = 8,
	BuildDuration = 5,
	SendEco = 0,
	Speed = 3.2
}))