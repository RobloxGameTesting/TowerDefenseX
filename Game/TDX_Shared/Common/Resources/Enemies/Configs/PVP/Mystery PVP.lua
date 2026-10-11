local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Mystery = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Mystery"))
local extended = TableUtilities.Extend(Mystery, {
	OverrideCharacterModelName = "Mystery",
	OverrideDisplayName = "Mystery",
	Speed = 5.6,
	Health = 5000,
	Shield = 2150,
	BodyHeat = 100,
	IsPVP = true,
	SendCost = 3500,
	UnlockWave = 30,
	BuildDuration = 6,
	SendEco = -165
})
extended.DeathSpawnData = {
	{
		EnemyTypeChanceMap = {
			[Enums.Enemies.MalicePVP] = 3,
			[Enums.Enemies.SludgeBoss] = 3,
			[Enums.Enemies.NeuronPVP] = 3,
			[Enums.Enemies.VoidBerserker] = 1
		},
		Count = 1,
		ExactPosition = true,
		NoCash = true
	}
}
return extended