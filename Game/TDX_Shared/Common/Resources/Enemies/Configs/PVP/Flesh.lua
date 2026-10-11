local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 600,
	BuildDuration = 5,
	UnlockWave = 13,
	SendEco = 32,
	Health = 333,
	Shield = 33,
	Speed = 9,
	AnimationCalibratedSpeed = 9,
	BodyHeat = 190,
	BodyHeatRegenerationRate = 40,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}