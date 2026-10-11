local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000,
	Shield = 500000,
	Speed = 1.6,
	AnimationCalibratedSpeed = 3.5,
	BodyHeat = 5,
	BodyHeatRegenerationRate = 2.5,
	OverrideDisplayName = "Atrazine",
	Radius = 1,
	HoverHeight = 1.2,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.AtrazineDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.15 }
	}
}