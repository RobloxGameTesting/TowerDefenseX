local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 1200,
	BuildDuration = 3,
	UnlockWave = 17,
	SendEco = 10,
	Health = 1350,
	Shield = 250,
	Speed = 4,
	AnimationCalibratedSpeed = 4,
	BodyHeat = 1200,
	BodyHeatRegenerationRate = 100,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.15 }
	}
}