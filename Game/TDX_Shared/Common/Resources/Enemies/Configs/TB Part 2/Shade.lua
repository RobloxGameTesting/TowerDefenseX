local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 400,
	Shield = 500,
	Speed = 4.8,
	AlwaysStealthed = true,
	BodyHeat = 200,
	BodyHeatRegenerationRate = 24,
	Radius = 0.83,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 4.3,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.6 }
	}
}