local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 200,
	Speed = 4.5,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 75,
	BodyHeatRegenerationRate = 5,
	Radius = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.CorrodedDeath,
	FakeEnemy = false,
	DamageReductionTable = {}
}