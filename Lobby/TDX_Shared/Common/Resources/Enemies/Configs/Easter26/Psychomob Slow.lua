local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2800,
	Shield = 100,
	Speed = 3,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 120,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}