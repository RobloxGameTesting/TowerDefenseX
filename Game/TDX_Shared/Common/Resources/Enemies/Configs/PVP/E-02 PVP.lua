local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local E02 = require(script.Parent.Parent:WaitForChild("Nightmare"):WaitForChild("E-02"))
return (TableUtilities.Extend(E02, {
	OverrideCharacterModelName = "E-02",
	OverrideDisplayName = "E-02",
	IsPVP = true,
	SendCost = 17000,
	UnlockWave = 36,
	BuildDuration = 5,
	SendEco = -275,
	Health = 35000,
	Shield = 0,
	BodyHeat = 2000,
	BodyHeatRegenerationRate = 350,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.75 }
	},
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.E02Burst] = { DamageMultiplier = 0.6 }
		}
	}
}))