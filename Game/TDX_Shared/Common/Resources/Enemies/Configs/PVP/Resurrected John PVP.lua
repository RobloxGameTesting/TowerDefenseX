local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local ResurrectedJohn = require(script.Parent.Parent:WaitForChild("Endless"):WaitForChild("Resurrected John"))
return (TableUtilities.Extend(ResurrectedJohn, {
	OverrideCharacterModelName = "Resurrected John",
	OverrideDisplayName = "Resurrected John",
	IsPVP = true,
	SendCost = 20000,
	UnlockWave = 25,
	BuildDuration = 8,
	BodyHeatRegenerationRate = 100,
	SendEco = -750,
	AbilityNames = { Enums.EnemyAbilities.ResurrectedJohnPVPRage },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 }
	}
}))