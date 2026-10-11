local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local RangerBot2 = require(script.Parent.Parent:WaitForChild("Christmas25"):WaitForChild("Ranger Bot 2"))
return (TableUtilities.Extend(RangerBot2, {
	OverrideCharacterModelName = "Ranger Bot 2",
	OverrideDisplayName = "Ranger Bot 2",
	IsPVP = true,
	SendCost = 410,
	UnlockWave = 11,
	BuildDuration = 3,
	SendEco = -10,
	BodyHeat = 200,
	BodyHeatRegenerationRate = 20,
	AttackData = {
		{ Range = 18, Damage = 10, ReloadTime = 2.5, BurstInterval = 0.16 }
	}
}))