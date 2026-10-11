local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 60,
	BuildDuration = 3,
	UnlockWave = 2,
	SendEco = 5,
	Health = 16,
	Speed = 3.4,
	AnimationCalibratedSpeed = 2.7,
	BodyHeat = 35,
	BodyHeatRegenerationRate = 1,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.15 }
	}
}