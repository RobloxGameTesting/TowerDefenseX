local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2400,
	Speed = 2.25,
	AnimationCalibratedSpeed = 2.25,
	BodyHeat = 700,
	BodyHeatRegenerationRate = 100,
	Shield = 1000,
	Radius = 1,
	HoverHeight = 2.0875,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}