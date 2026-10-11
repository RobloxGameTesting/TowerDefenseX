local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local CyberSanta = require(script.Parent.Parent:WaitForChild("Christmas"):WaitForChild("Cyber Santa"))
return (TableUtilities.Extend(CyberSanta, {
	OverrideCharacterModelName = "Cyber Santa",
	OverrideDisplayName = "Exo Santa",
	OverrideCustomCodeName = "Cyber Santa",
	HeadshotImage = "rbxassetid://102023333271151",
	IsPVP = true,
	Health = 512250,
	SendCost = 251225,
	UnlockWave = 38,
	BuildDuration = 30,
	PVPCashPerDamageMultiplier = 0.2,
	SendEco = -2800,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.CyberSantaBurstAttack] = { DamageMultiplier = 13 },
			[Enums.EnemyAbilities.CyberSantaSpamAttack] = { DamageMultiplier = 10 }
		}
	}
}))