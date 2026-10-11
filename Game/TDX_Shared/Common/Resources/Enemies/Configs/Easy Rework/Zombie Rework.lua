local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Zombie",
	Health = 8,
	Speed = 2.8,
	BodyHeat = 4,
	BodyHeatRegenerationRate = 0.5,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}