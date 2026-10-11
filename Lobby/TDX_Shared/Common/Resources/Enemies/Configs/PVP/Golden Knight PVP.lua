local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local GoldenKnight = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("Golden Knight"))
return (TableUtilities.Extend(GoldenKnight, {
	OverrideCharacterModelName = "Golden Knight",
	OverrideDisplayName = "Golden Knight",
	IsPVP = true,
	SendCost = 3000,
	UnlockWave = 30,
	BuildDuration = 1.5,
	SendEco = 40,
	Health = 3000,
	Shield = 2500,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.45 }
	}
}))