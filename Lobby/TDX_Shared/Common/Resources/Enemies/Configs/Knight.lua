local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1346,
	Speed = 2.8,
	BodyHeat = 185,
	BodyHeatRegenerationRate = 40,
	Radius = 1,
	HoverHeight = 1.65,
	AnimationTimeScale = 1.25,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FakeEnemy = false
}