local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100000,
	Shield = 100000,
	Speed = 4.3,
	BodyHeat = 25000,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3.6,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.4 }
	},
	FakeEnemy = false
}