local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 525,
	BuildDuration = 4,
	UnlockWave = 9,
	SendEco = 10,
	Health = 375,
	Shield = 625,
	Speed = 2.1,
	AnimationCalibratedSpeed = 1.7,
	BodyHeat = 300,
	BodyHeatRegenerationRate = 25,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 }
	}
}