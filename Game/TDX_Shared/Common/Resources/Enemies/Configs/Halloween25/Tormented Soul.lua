local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 350,
	Shield = 350,
	Speed = 5.8,
	BodyHeat = 300,
	BodyHeatRegenerationRate = 25,
	Radius = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.TormentedSoulDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 }
	},
	GhostlyUnit = true
}