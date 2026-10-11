local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local GiantGrenadierBot = require(script.Parent.Parent:WaitForChild("Christmas25"):WaitForChild("Giant Grenadier Bot"))
return (TableUtilities.Extend(GiantGrenadierBot, {
	OverrideCharacterModelName = "Giant Grenadier Bot",
	OverrideDisplayName = "Giant Grenadier Bot",
	OverrideCustomCodeName = "Giant Grenadier Bot",
	IsPVP = true,
	SendCost = 20000,
	UnlockWave = 25,
	BuildDuration = 6.5,
	SendEco = -75,
	PVPCashPerDamageMultiplier = 0,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 200,
	AttackData = {
		{ Range = 14, SplashRadius = 1 }
	}
}))