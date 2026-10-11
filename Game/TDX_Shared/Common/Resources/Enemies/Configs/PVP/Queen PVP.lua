local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Queen = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("Queen"))
return (TableUtilities.Extend(Queen, {
	OverrideCharacterModelName = "Queen",
	OverrideDisplayName = "Queen",
	HeadshotImage = "rbxassetid://106194419004337",
	IsPVP = true,
	SendCost = 28000,
	UnlockWave = 28,
	BuildDuration = 20,
	SendEco = -500,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.QueenCrossbow] = { DamageMultiplier = 2.5 }
		}
	}
}))