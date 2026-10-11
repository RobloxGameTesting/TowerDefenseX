local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 375,
	Speed = 12,
	AnimationCalibratedSpeed = 9,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 8,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	Stealth = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}