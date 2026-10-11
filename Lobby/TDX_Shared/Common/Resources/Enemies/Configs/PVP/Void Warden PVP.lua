local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local VoidWarden = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Void Warden"))
return (TableUtilities.Extend(VoidWarden, {
	OverrideCharacterModelName = "Void Warden",
	OverrideDisplayName = "Void Warden",
	AbilityNames = { Enums.EnemyAbilities.VoidWardenPVPCrystalShot, Enums.EnemyAbilities.VoidWardenPVPCrystalShotAir },
	Speed = 3,
	IsPVP = true,
	SendCost = 45000,
	UnlockWave = 30,
	BuildDuration = 7,
	SendEco = -100
}))