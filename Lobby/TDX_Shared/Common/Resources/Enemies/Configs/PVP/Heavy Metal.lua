local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 1900,
	BuildDuration = 5.5,
	UnlockWave = 26,
	SendEco = 105,
	Health = 4800,
	Speed = 6.2,
	AnimationCalibratedSpeed = 6,
	BodyHeat = 1750,
	BodyHeatRegenerationRate = 160,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.4 }
	}
}