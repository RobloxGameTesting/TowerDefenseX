local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Destructor = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Destructor"))
return (TableUtilities.Extend(Destructor, {
	OverrideCharacterModelName = "Destructor",
	OverrideDisplayName = "Destructor",
	OverrideCustomCodeName = "Destructor",
	HeadshotImage = "rbxassetid://73120978875372",
	IsPVP = true,
	SendCost = 380000,
	UnlockWave = 40,
	BuildDuration = 20,
	PVPCashPerDamageMultiplier = 0.3,
	SendEco = -5000,
	Health = 675000,
	Shield = 100000,
	BodyHeat = 19500,
	BodyHeatRegenerationRate = 220
}))