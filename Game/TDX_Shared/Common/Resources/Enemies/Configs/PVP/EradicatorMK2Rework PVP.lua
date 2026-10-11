local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local EradicatorMK2Rework = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("EradicatorMK2Rework"))
return (TableUtilities.Extend(EradicatorMK2Rework, {
	OverrideCharacterModelName = "EradicatorMK2Rework",
	OverrideCustomCodeName = "EradicatorMK2Rework",
	HeadshotImage = "rbxassetid://121829065623198",
	IsPVP = true,
	SendCost = 1000000,
	UnlockWave = 42,
	BuildDuration = 30,
	PVPCashPerDamageMultiplier = 0.6,
	SendEco = -9000,
	Speed = 1.7,
	Health = 750000,
	Shield = 100000,
	BodyHeat = 20500,
	BodyHeatRegenerationRate = 220,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.6 }
	},
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.EradicatorMK2ReworkShieldHeal] = { HealAmountMultiplier = 0.75 },
			[Enums.EnemyAbilities.EradicatorMK2ReworkRocketStorm] = { DamageMultiplier = 0.8 },
			[Enums.EnemyAbilities.EradicatorMK2ReworkMinigunStrafe] = { DamageMultiplier = 0.8 },
			[Enums.EnemyAbilities.EradicatorMK2ReworkDroneSupport] = { Disabled = true },
			[Enums.EnemyAbilities.EradicatorMK2ReworkRage_DroneSupport] = { Disabled = true }
		}
	}
}))