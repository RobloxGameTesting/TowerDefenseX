local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Normal",
	Health = 115,
	Shield = 100,
	Speed = 3.4,
	BodyHeat = 24,
	BodyHeatRegenerationRate = 1,
	Radius = 0.86,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3.2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}