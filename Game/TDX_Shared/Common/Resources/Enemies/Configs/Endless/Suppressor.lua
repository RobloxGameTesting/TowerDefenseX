local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 69000,
	NoCash = true,
	Speed = 3.1,
	AnimationCalibratedSpeed = 2.5,
	BodyHeat = 8000,
	BodyHeatRegenerationRate = 1500,
	Radius = 1,
	HoverHeight = 1.74,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}