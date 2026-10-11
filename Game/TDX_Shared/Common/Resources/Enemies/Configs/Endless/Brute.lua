local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2000,
	Shield = 500,
	Speed = 2.4,
	AnimationCalibratedSpeed = 1.1,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 95,
	Radius = 1,
	HoverHeight = 2.122,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}