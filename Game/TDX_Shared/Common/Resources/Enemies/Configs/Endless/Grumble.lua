local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100000,
	InstantLossIfReachEnd = true,
	Speed = 3.6,
	AnimationCalibratedSpeed = 2.72,
	BodyHeat = 12000,
	BodyHeatRegenerationRate = 300,
	Radius = 1,
	HoverHeight = 2.5120000000000005,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GrumbleDeath,
	FakeEnemy = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenPart4] = { Health = 50000, Shield = nil }
	}
}