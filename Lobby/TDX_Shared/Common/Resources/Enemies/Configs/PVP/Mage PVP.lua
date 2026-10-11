local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Mage = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("Mage"))
return (TableUtilities.Extend(Mage, {
	OverrideCharacterModelName = "Mage",
	OverrideDisplayName = "Mage",
	IsPVP = true,
	SendCost = 2050,
	UnlockWave = 14,
	BuildDuration = 8,
	SendEco = -20,
	Health = 825,
	BodyHeatRegenerationRate = 45,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.75 }
	},
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.MageSummon] = { Cooldown = 40 },
			[Enums.EnemyAbilities.MageFireball] = { DamageMultiplier = 2 }
		}
	}
}))