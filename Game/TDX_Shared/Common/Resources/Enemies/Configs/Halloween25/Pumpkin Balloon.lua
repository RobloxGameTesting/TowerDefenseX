local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 8000,
	Speed = 3,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 30,
	BodyHeatRegenerationRate = 7,
	Radius = 1,
	AirUnit = true,
	NoHead = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.PumpkinBalloonDeath,
	FakeEnemy = false,
	DamageReductionTable = {}
}