local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 550,
	BuildDuration = 2.5,
	UnlockWave = 17,
	SendEco = 10,
	Health = 350,
	AlwaysStealthed = true,
	Shield = 300,
	Speed = 5.5,
	AnimationCalibratedSpeed = 5,
	BodyHeat = 340,
	BodyHeatRegenerationRate = 25,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.65 }
	}
}