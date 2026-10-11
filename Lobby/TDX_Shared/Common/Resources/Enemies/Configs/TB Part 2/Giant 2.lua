local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 25000,
	Speed = 8.2,
	BodyHeat = 4000,
	BodyHeatRegenerationRate = 450,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 8.2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}