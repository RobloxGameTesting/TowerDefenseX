local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 70000,
	Speed = 3.5,
	NoCash = true,
	AnimationCalibratedSpeed = 3.5,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.AtrazineDeath,
	FakeEnemy = false
}