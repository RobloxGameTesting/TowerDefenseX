local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local VoidPrime = require(script.Parent.Parent:WaitForChild("TB Part 2"):WaitForChild("Void Prime"))
return (TableUtilities.Extend(VoidPrime, {
	OverrideCharacterModelName = "Void Prime",
	OverrideDisplayName = "Void Prime",
	OverrideCustomCodeName = Enums.Enemies.VoidPrime,
	HeadshotImage = "rbxassetid://114959545868364",
	AbilityNames = {
		Enums.EnemyAbilities.VoidPrimePVPSwordSlam,
		Enums.EnemyAbilities.VoidPrimePVPStomp,
		Enums.EnemyAbilities.VoidPrimePVPBoomerang,
		Enums.EnemyAbilities.VoidPrimePVPClawCalling,
		Enums.EnemyAbilities.VoidPrimePVPRage,
		Enums.EnemyAbilities.VoidPrimePVPEmpBlade,
		Enums.EnemyAbilities.VoidPrimePVPBladeSpam,
		Enums.EnemyAbilities.VoidPrimePVPExecute,
		Enums.EnemyAbilities.VoidPrimePVPVoidCalling,
		Enums.EnemyAbilities.VoidPrimePVPBladeSpin
	},
	Speed = 2.9,
	Health = 2900000,
	IsPVP = true,
	SendCost = 1750000,
	UnlockWave = 45,
	BuildDuration = 55,
	SendEco = -27000
}))