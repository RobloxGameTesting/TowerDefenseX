local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local AlphaPredator = require(script.Parent.Parent:WaitForChild("Nightmare"):WaitForChild("Alpha Predator"))
return (TableUtilities.Extend(AlphaPredator, {
	OverrideCharacterModelName = "Alpha Predator",
	OverrideDisplayName = "Alpha Predator",
	OverrideCustomCodeName = "Alpha Predator",
	HeadshotImage = "rbxassetid://83004878941143",
	IsPVP = true,
	SendCost = 1850000,
	UnlockWave = 45,
	BuildDuration = 60,
	PVPCashPerDamageMultiplier = 0.5,
	SendEco = -30000,
	Health = 1800000,
	Shield = 300000,
	BodyHeat = 28000,
	BodyHeatRegenerationRate = 350,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	},
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.AlphaPredatorMissiles] = { DamageMultiplier = 0.35 },
			[Enums.EnemyAbilities.AlphaPredatorLaserArc] = { DamageMultiplier = 0.5 },
			[Enums.EnemyAbilities.AlphaPredatorHammerSlam] = { DamageMultiplier = 0.8 },
			[Enums.EnemyAbilities.AlphaPredatorHammerSlam_Gunshot] = { DamageMultiplier = 0.3 },
			[Enums.EnemyAbilities.AlphaPredatorLaserEye] = { DamageMultiplier = 0.75 },
			[Enums.EnemyAbilities.AlphaPredatorFlamethrower] = { DamageMultiplier = 0.9 },
			[Enums.EnemyAbilities.AlphaPredatorNukeThrow] = { DamageMultiplier = 0.5 }
		}
	}
}))