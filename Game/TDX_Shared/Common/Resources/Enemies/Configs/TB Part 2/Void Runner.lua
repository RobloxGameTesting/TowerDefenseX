local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50000,
	Shield = 120000,
	Speed = 9,
	BodyHeat = 3000,
	BodyHeatRegenerationRate = 750,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 8.7,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 }
	},
	FakeEnemy = false
}