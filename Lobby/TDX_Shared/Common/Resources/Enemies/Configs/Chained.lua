local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 165,
	Speed = 1.8,
	BodyHeat = 60,
	BodyHeatRegenerationRate = 6,
	Radius = 1,
	HoverHeight = 1.65,
	AnimationTimeScale = 0.9,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FakeEnemy = false
}