local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideCharacterModelName = Enums.Enemies.TestAirUnit,
	AirUnit = true,
	Health = 10000,
	Speed = 1.5,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 250,
	Radius = 1,
	HoverHeight = 100,
	HoverHeightVariance = 0.5,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}