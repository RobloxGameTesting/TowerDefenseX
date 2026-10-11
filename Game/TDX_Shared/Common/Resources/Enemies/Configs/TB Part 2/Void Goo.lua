local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000,
	Shield = 5000,
	Speed = 2.9,
	BodyHeat = 250,
	BodyHeatRegenerationRate = 80,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.9,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.2 }
	},
	FakeEnemy = false
}