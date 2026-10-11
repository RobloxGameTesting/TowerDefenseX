local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 75000,
	Shield = 10000,
	Speed = 4.5,
	AnimationCalibratedSpeed = 3.3,
	BodyHeat = 20000,
	BodyHeatRegenerationRate = 2500,
	Radius = 1,
	HoverHeight = 1.82,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}