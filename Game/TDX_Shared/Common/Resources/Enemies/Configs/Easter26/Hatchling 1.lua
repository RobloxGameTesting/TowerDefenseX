local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100,
	Speed = 8,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 1.5,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 8,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	NoHead = true,
	DamageReductionTable = {}
}