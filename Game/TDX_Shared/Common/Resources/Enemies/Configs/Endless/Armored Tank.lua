local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 7000,
	Shield = 3000,
	Speed = 3.5,
	AnimationCalibratedSpeed = 3.5,
	BodyHeat = 1250,
	BodyHeatRegenerationRate = 250,
	Radius = 1,
	HoverHeight = 2.122,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.2 }
	}
}