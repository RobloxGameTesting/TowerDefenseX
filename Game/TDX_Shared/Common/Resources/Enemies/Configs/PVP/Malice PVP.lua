local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Malice = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Malice"))
return (TableUtilities.Extend(Malice, {
	OverrideCharacterModelName = "Malice",
	OverrideDisplayName = "Malice",
	AbilityNames = { Enums.EnemyAbilities.MalicePVPZoneDeploy },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.98 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.98 }
	},
	IsPVP = true,
	SendCost = 5000,
	UnlockWave = 23,
	BuildDuration = 8,
	SendEco = -120
}))