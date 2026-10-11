local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Jumper = require(script.Parent.Parent:WaitForChild("Expert Rework"):WaitForChild("Jumper"))
return (TableUtilities.Extend(Jumper, {
	OverrideCharacterModelName = "Jumper",
	OverrideDisplayName = "Jumper",
	IsPVP = true,
	SendCost = 1650,
	UnlockWave = 12,
	BuildDuration = 7,
	SendEco = 0,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.JumperJump] = {
				CooldownVariance = 0,
				StartingCooldownVariance = 0
			}
		}
	}
}))