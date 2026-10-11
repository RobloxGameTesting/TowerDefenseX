local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Heavy Zombie",
	Health = 30,
	Shield = 10,
	Speed = 1.9,
	BodyHeat = 20,
	BodyHeatRegenerationRate = 2.5,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 1.9,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}