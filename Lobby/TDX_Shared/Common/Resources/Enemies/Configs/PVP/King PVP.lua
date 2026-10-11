local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local King = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("King"))
return (TableUtilities.Extend(King, {
	OverrideCharacterModelName = "King",
	OverrideDisplayName = "King",
	HeadshotImage = "rbxassetid://72299556502897",
	IsPVP = true,
	SendCost = 80000,
	UnlockWave = 31,
	BuildDuration = 18,
	SendEco = -750,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.KingSwordStun] = { DamageMultiplier = 6 },
			[Enums.EnemyAbilities.KingSwordSlash] = { DamageMultiplier = 5 }
		}
	}
}))