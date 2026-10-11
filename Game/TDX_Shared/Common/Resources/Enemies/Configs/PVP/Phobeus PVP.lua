local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Phobeus = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Phobeus"))
return (TableUtilities.Extend(Phobeus, {
	OverrideCharacterModelName = "Phobeus",
	OverrideDisplayName = "Phoebus",
	OverrideCustomCodeName = "Phobeus",
	HeadshotImage = "rbxassetid://99088442466734",
	IsPVP = true,
	SendCost = 85000,
	UnlockWave = 30,
	BuildDuration = 20,
	PVPCashPerDamageMultiplier = 0.25,
	SendEco = -1200,
	BodyHeat = 19000
}))