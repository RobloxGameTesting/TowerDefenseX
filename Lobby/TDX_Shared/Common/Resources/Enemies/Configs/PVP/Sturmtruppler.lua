local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 2750,
	BuildDuration = 4,
	UnlockWave = 30,
	SendEco = 20,
	Health = 10000,
	Shield = 2500,
	AlwaysStealthed = true,
	Speed = 7,
	AnimationCalibratedSpeed = 7,
	BodyHeat = 550,
	BodyHeatRegenerationRate = 165,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.35 }
	}
}