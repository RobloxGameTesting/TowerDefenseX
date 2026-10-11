local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Ghost",
	AirUnit = true,
	Health = 50,
	Speed = 4,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 1,
	BodyHeatRegenerationRate = 1,
	Radius = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.CorrodedDeath,
	FakeEnemy = false,
	DamageReductionTable = {}
}