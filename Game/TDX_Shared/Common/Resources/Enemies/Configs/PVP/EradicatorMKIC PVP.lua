local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local EradicatorMKIC = require(script.Parent.Parent:WaitForChild("Endless"):WaitForChild("EradicatorMKIC"))
return (TableUtilities.Extend(EradicatorMKIC, {
	OverrideCharacterModelName = "EradicatorMKIC",
	OverrideCustomCodeName = "EradicatorMKIC",
	HeadshotImage = "rbxassetid://76754013420651",
	IsPVP = true,
	SendCost = 1250000,
	UnlockWave = 43,
	BuildDuration = 30,
	PVPCashPerDamageMultiplier = 0.5,
	SendEco = -7000,
	Health = 725000,
	BodyHeat = 21000,
	BodyHeatRegenerationRate = 240,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.EradicatorMKICRocketStorm] = {
				DamageMultiplier = 0.8,
				StartingCooldown = 5
			},
			[Enums.EnemyAbilities.EradicatorMKICEnergyShield] = { HealAmountMultiplier = 0.45 },
			[Enums.EnemyAbilities.EradicatorMKICSwordShock] = {
				Cooldown = 85,
				StartingCooldown = 18
			},
			[Enums.EnemyAbilities.EradicatorMKICSwordEarthquake] = { DamageMultiplier = 0.75 }
		}
	}
}))