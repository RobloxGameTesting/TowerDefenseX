local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local SlimeCaptain1 = require(script.Parent.Parent:WaitForChild("Slime Event"):WaitForChild("SlimeCaptain1"))
return (TableUtilities.Extend(SlimeCaptain1, {
	OverrideCharacterModelName = "SlimeCaptain1",
	OverrideDisplayName = "Captain Slime",
	IsPVP = true,
	SendCost = 100000,
	UnlockWave = 31,
	BuildDuration = 25,
	PVPCashPerDamageMultiplier = 0.05,
	SendEco = -500,
	BodyHeat = 15000,
	BodyHeatRegenerationRate = 180,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.25 }
	}
}))