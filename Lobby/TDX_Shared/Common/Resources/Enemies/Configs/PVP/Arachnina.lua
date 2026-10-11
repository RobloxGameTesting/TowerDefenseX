local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 23500,
	BuildDuration = 4,
	UnlockWave = 32,
	SendEco = -125,
	Health = 38000,
	Shield = 18000,
	Speed = 3,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 2100,
	BodyHeatRegenerationRate = 190,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.15 }
	}
}