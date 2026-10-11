local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Eradicator = require(script.Parent.Parent:WaitForChild("Eradicator"))
return (TableUtilities.Extend(Eradicator, {
	OverrideCharacterModelName = "Eradicator",
	OverrideDisplayName = "Eradicator",
	OverrideCustomCodeName = "Eradicator",
	HeadshotImage = "rbxassetid://90798991013458",
	IsPVP = true,
	SendCost = 45000,
	UnlockWave = 29,
	BuildDuration = 20,
	PVPCashPerDamageMultiplier = 0.05,
	SendEco = -400
}))