local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local TB2Normal = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("TB2 Normal"))
return (TableUtilities.Extend(TB2Normal, {
	OverrideCharacterModelName = "TB2 Normal",
	Health = 20,
	Shield = 0,
	BodyHeat = 35,
	IsPVP = true,
	SendCost = 65,
	UnlockWave = 2,
	BuildDuration = 3.2,
	SendEco = 5
}))