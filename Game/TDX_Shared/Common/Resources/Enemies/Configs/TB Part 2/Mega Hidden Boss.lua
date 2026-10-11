local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	NoStealthName = true,
	AlwaysStealthed = true,
	NoStealthShimmer = true,
	Health = 50000,
	Shield = 25000,
	Speed = 7,
	AnimationCalibratedSpeed = 3.06,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 450,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.95 }
	}
}