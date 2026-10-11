local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local M1BTank = require(script.Parent.Parent:WaitForChild("Christmas25"):WaitForChild("M1 B-Tank"))
return (TableUtilities.Extend(M1BTank, {
	OverrideCharacterModelName = "M1 B-Tank",
	OverrideDisplayName = "M1 B-Tank",
	IsPVP = true,
	SendCost = 30000,
	UnlockWave = 27,
	BuildDuration = 7,
	PVPCashPerDamageMultiplier = 0.1,
	SendEco = -275,
	Health = 35000,
	Shield = 12000,
	AttackData = {
		{
			Range = 37,
			Damage = 6000,
			ReloadTime = 2.5,
			MinimumRange = 3,
			SplashRadius = 2,
			AlwaysTargetPathEntities = true,
			NoTargetTowers = true
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 }
	}
}))