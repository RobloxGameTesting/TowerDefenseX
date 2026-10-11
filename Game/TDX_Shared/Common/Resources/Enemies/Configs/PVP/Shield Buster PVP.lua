local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local ShieldBuster = require(script.Parent.Parent:WaitForChild("Christmas25"):WaitForChild("Shield Buster"))
return (TableUtilities.Extend(ShieldBuster, {
	OverrideCharacterModelName = "Shield Buster",
	OverrideDisplayName = "Shield Buster",
	IsPVP = true,
	Shield = 10000,
	SendCost = 40000,
	UnlockWave = 32,
	BuildDuration = 4,
	SendEco = -50
}))