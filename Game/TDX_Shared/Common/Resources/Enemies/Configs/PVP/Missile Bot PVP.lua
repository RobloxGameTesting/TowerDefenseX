local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local MissileBot = require(script.Parent.Parent:WaitForChild("Christmas25"):WaitForChild("Missile Bot"))
return (TableUtilities.Extend(MissileBot, {
	OverrideCharacterModelName = "Missile Bot",
	OverrideDisplayName = "Missile Bot",
	IsPVP = true,
	SendCost = 1250,
	UnlockWave = 13,
	BuildDuration = 6,
	SendEco = -25,
	AttackData = {
		{ Damage = 100, ReloadTime = 1.6, SplashRadius = 1.8 }
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.55 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.35 }
	}
}))