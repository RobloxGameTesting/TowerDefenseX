local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local HeavyTitan = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Heavy Titan"))
return (TableUtilities.Extend(HeavyTitan, {
	OverrideCharacterModelName = "Heavy Titan",
	OverrideDisplayName = "Heavy Titan",
	IsPVP = true,
	SendCost = 1100,
	UnlockWave = 10,
	BuildDuration = 7,
	SendEco = 0,
	BodyHeatRegenerationRate = 25,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.45 }
	}
}))