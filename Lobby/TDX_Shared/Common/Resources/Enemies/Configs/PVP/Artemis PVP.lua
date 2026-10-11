local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Artemis = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Artemis"))
return (TableUtilities.Extend(Artemis, {
	OverrideCharacterModelName = "Artemis",
	OverrideDisplayName = "Artemis",
	OverrideCustomCodeName = "Artemis",
	HeadshotImage = "rbxassetid://120298362629779",
	IsPVP = true,
	SendCost = 90000,
	UnlockWave = 35,
	BuildDuration = 9,
	PVPCashPerDamageMultiplier = 0.3,
	SendEco = -1050,
	Health = 20000,
	Shield = 7000,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.ArtemisRageBeams] = { DamageMultiplier = 0.5 },
			[Enums.EnemyAbilities.ArtemisPlasmaBeam] = { DamageMultiplier = 0.75 },
			[Enums.EnemyAbilities.ArtemisRage] = { DamageMultiplier = 0.5 },
			[Enums.EnemyAbilities.ArtemisDeathExplosion] = { DamageMultiplier = 0.2 }
		}
	}
}))