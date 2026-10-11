local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 250,
	Shield = 30,
	Speed = 7.2,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 12,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 7,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}