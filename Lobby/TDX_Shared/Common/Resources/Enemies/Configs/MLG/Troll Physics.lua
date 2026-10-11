local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 7000,
	Speed = 6.5,
	BodyHeat = 4400,
	BodyHeatRegenerationRate = 1200,
	Radius = 1,
	HoverHeightVariance = 0.75,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}