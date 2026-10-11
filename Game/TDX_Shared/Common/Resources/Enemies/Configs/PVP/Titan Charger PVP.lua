local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local TitanCharger = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Titan Charger"))
return (TableUtilities.Extend(TitanCharger, {
	OverrideCharacterModelName = "Titan Charger",
	OverrideDisplayName = "Titan Charger",
	IsPVP = true,
	SendCost = 19000,
	UnlockWave = 26,
	BuildDuration = 4,
	SendEco = -75,
	BodyHeatRegenerationRate = 300,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.7 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.9 }
	}
}))