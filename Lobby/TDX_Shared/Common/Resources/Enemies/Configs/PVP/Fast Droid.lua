local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 40,
	UnlockWave = 3,
	BuildDuration = 1,
	SendEco = 1,
	Health = 14,
	Speed = 9,
	AnimationCalibratedSpeed = 9,
	BodyHeat = 35,
	BodyHeatRegenerationRate = 2,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.35 }
	}
}