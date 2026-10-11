local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 1250,
	BuildDuration = 3,
	UnlockWave = 22,
	SendEco = 5,
	Health = 3500,
	Shield = 1750,
	AlwaysStealthed = true,
	Speed = 3.2,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 1350,
	BodyHeatRegenerationRate = 150,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.75 }
	}
}