local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Knyght = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("Knyght"))
return (TableUtilities.Extend(Knyght, {
	OverrideCharacterModelName = "Knyght",
	OverrideDisplayName = "Knyght",
	IsPVP = true,
	SendCost = 375,
	UnlockWave = 14,
	BuildDuration = 3,
	SendEco = 25,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.55 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.45 }
	}
}))