local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Mutated Offspring",
	Health = 30,
	Shield = 30,
	Speed = 9,
	BodyHeat = 5,
	BodyHeatRegenerationRate = 1,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 7,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}