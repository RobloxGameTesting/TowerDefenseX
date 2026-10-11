local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Neuron = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Neuron"))
return (TableUtilities.Extend(Neuron, {
	OverrideCharacterModelName = "Neuron",
	OverrideDisplayName = "Neuron",
	DeathSpawnData = {
		{ Count = 0 }
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.65 }
	},
	Speed = 16,
	IsPVP = true,
	SendCost = 7000,
	UnlockWave = 27,
	BuildDuration = 6,
	SendEco = -65
}))