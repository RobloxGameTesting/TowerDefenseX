local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 8550,
	BuildDuration = 4,
	UnlockWave = 37,
	SendEco = -150,
	Health = 25000,
	Shield = 2500,
	Speed = 12,
	AnimationCalibratedSpeed = 12,
	BodyHeat = 1500,
	BodyHeatRegenerationRate = 190,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.7 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.3 }
	}
}