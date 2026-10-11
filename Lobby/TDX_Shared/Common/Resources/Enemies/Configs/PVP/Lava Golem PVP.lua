local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local LavaGolem = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("Lava Golem"))
return (TableUtilities.Extend(LavaGolem, {
	OverrideCharacterModelName = "Lava Golem",
	OverrideDisplayName = "Lava Golem",
	IsPVP = true,
	SendCost = 6750,
	UnlockWave = 17,
	BuildDuration = 8,
	SendEco = -85,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.85 }
	}
}))