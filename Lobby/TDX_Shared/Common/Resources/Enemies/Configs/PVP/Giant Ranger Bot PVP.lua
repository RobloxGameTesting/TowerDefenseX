local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local GiantRangerRobot = require(script.Parent.Parent:WaitForChild("Christmas25"):WaitForChild("Giant Ranger Robot"))
return (TableUtilities.Extend(GiantRangerRobot, {
	OverrideCharacterModelName = "Giant Ranger Robot",
	OverrideDisplayName = "Giant Ranger Bot",
	IsPVP = true,
	SendCost = 27550,
	UnlockWave = 26,
	BuildDuration = 7,
	SendEco = -150,
	BodyHeat = 2500,
	BodyHeatRegenerationRate = 360,
	AttackData = {
		{ Range = 12, Damage = 255, ReloadTime = 1, BurstInterval = 0.15 }
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	}
}))