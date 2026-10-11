local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	NoStealthName = true,
	AlwaysStealthed = true,
	NoStealthShimmer = true,
	Health = 100,
	Speed = 7.5,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 1,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 7.5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}