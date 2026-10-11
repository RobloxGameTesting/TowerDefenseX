local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 25000,
	Shield = 15000,
	Speed = 5,
	BodyHeat = 1200,
	BodyHeatRegenerationRate = 140,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 4.6,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.8 }
	},
	FakeEnemy = false
}