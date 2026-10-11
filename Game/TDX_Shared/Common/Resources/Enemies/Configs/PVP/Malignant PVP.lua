local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Malignant = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Malignant"))
return (TableUtilities.Extend(Malignant, {
	OverrideCharacterModelName = "Malignant",
	OverrideDisplayName = "Malignant",
	AbilityNames = { Enums.EnemyAbilities.MalignantPVPSummon, Enums.EnemyAbilities.MalignantPVPEnemyBuff },
	Shield = 2500,
	BodyHeat = 2000,
	IsPVP = true,
	SendCost = 6000,
	UnlockWave = 19,
	BuildDuration = 13,
	SendEco = -80
}))