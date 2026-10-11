local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local MysteryV = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Mystery V"))
local extended = TableUtilities.Extend(MysteryV, {
	OverrideCharacterModelName = "Mystery V",
	OverrideDisplayName = "Mystery V",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	},
	Health = 500,
	IsPVP = true,
	SendCost = 400,
	UnlockWave = 14,
	BuildDuration = 5.5,
	SendEco = -20
})
extended.DeathSpawnData = {
	{
		EnemyTypeChanceMap = {
			[Enums.Enemies.TB2Speed] = 1,
			[Enums.Enemies.Boss1] = 1,
			[Enums.Enemies.SlowPVP] = 5,
			[Enums.Enemies.ShadePVP] = 5,
			[Enums.Enemies.NormalPVP] = 5,
			[Enums.Enemies.NosowyPVP] = 3
		},
		Count = 1,
		ExactPosition = true,
		NoCash = true
	}
}
return extended