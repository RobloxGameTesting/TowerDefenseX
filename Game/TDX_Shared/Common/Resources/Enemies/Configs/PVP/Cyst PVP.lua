local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Cyst = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Cyst"))
return (TableUtilities.Extend(Cyst, {
	OverrideCharacterModelName = "Cyst",
	OverrideDisplayName = "Cyst",
	AbilityNames = { Enums.EnemyAbilities.CystPVPFire, Enums.EnemyAbilities.CystPVPFireAA },
	Health = 300,
	Shield = 50,
	IsPVP = true,
	SendCost = 1000,
	UnlockWave = 13,
	BuildDuration = 6,
	SendEco = -30
}))