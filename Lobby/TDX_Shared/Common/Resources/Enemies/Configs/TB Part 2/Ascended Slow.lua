local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 25,
	Shield = 1025,
	Speed = 1.2,
	BodyHeat = 4000,
	BodyHeatRegenerationRate = 750,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 0.6,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	KnockbackResistance = true,
	SuperStunResistance = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Toxic, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.4 }
	}
}