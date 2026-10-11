local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1000,
	Speed = 1.9,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 1,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 1.9,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}