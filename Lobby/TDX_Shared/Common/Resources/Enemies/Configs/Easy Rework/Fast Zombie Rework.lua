local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Fast Zombie",
	Health = 8,
	Speed = 6.5,
	BodyHeat = 3,
	BodyHeatRegenerationRate = 0.5,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 7,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}