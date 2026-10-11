local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local PlagueDoctor = require(script.Parent.Parent:WaitForChild("Plague Doctor"))
return (TableUtilities.Extend(PlagueDoctor, {
	OverrideCharacterModelName = "Plague Doctor",
	OverrideDisplayName = "Plague Doctor",
	HeadshotImage = "rbxassetid://98739599999310",
	IsPVP = true,
	SendCost = 20135,
	UnlockWave = 23,
	BuildDuration = 15,
	PVPCashPerDamageMultiplier = 0,
	SendEco = -250,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.PlagueDoctorSummon] = { Cooldown = 80, StartingCooldown = 10 }
		}
	}
}))