local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local BatteringRam = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("Battering Ram"))
return (TableUtilities.Extend(BatteringRam, {
	OverrideCharacterModelName = "Battering Ram",
	OverrideDisplayName = "Battering Ram",
	IsPVP = true,
	SendCost = 95000,
	UnlockWave = 28,
	BuildDuration = 30,
	SendEco = -700,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.BatteringRamCharge] = { StartingCooldown = 7 }
		}
	}
}))