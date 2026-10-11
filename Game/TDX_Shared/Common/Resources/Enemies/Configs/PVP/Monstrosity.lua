local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 12750,
	BuildDuration = 6,
	UnlockWave = 33,
	SendEco = -90,
	Health = 60000,
	Shield = 10000,
	Speed = 3.3,
	AnimationCalibratedSpeed = 3.3,
	BodyHeat = 4500,
	BodyHeatRegenerationRate = 450,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 }
	}
}