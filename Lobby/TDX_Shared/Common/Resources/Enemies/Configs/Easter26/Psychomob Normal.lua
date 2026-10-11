local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Psychomob",
	Health = 235,
	Shield = 75,
	Speed = 3.3,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 12,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}