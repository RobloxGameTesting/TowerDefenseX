local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local EasterEngineer = require(script.Parent.Parent:WaitForChild("Easter26"):WaitForChild("Easter Engineer"))
return (TableUtilities.Extend(EasterEngineer, {
	OverrideCharacterModelName = "Easter Engineer",
	OverrideCustomCodeName = "Easter Engineer",
	SpawnAnimationTime = false,
	SpawnInvulnerabilityTime = false,
	IsPVP = true,
	SendCost = 125000,
	UnlockWave = 35,
	BuildDuration = 35,
	PVPCashPerDamageMultiplier = 0.3,
	SendEco = -1050,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 }
	},
	Health = 175000,
	Shield = 67
}))