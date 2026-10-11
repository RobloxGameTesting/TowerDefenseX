local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Hidden",
	NoStealthName = true,
	AlwaysStealthed = true,
	NoStealthShimmer = true,
	Health = 50,
	Speed = 4.8,
	AnimationCalibratedSpeed = 1.7,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 20,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.8 }
	}
}