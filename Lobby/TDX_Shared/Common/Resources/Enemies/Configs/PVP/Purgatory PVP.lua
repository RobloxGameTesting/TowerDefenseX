local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Purgatory = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Purgatory"))
return (TableUtilities.Extend(Purgatory, {
	OverrideCharacterModelName = "Purgatory",
	OverrideDisplayName = "Purgatory",
	IsPVP = true,
	SendCost = 4500,
	UnlockWave = 18,
	BuildDuration = 8,
	SendEco = -80,
	StealthDetection = true,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.PurgatoryAntiAirMissileAttack] = {
				Cooldown = 15,
				DamageMultiplier = 2
			},
			[Enums.EnemyAbilities.PurgatoryMissileAttack] = { Cooldown = 15, DamageMultiplier = 2 }
		}
	}
}))