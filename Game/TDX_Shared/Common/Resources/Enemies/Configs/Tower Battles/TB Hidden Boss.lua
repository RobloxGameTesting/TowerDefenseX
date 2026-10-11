local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Hidden Boss",
	NoStealthName = true,
	AlwaysStealthed = true,
	NoStealthShimmer = true,
	Health = 1250,
	Speed = 4,
	AnimationCalibratedSpeed = 1.8,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 450,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.7 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.7 }
	}
}