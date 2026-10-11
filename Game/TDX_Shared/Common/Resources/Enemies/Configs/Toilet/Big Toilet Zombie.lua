local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 32,
	Speed = 2.5,
	BodyHeat = 15,
	BodyHeatRegenerationRate = 5,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}