local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "The user being completely stripped from 3 of their senses after the event of arrival",
	AirUnit = true,
	Health = 16,
	Speed = 2,
	BodyHeat = 25,
	BodyHeatRegenerationRate = 5,
	Radius = 1,
	HoverHeightVariance = 0.75,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}