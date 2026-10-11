local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 95000,
	Speed = 3.4,
	AnimationCalibratedSpeed = 2.8,
	BodyHeat = 35000,
	BodyHeatRegenerationRate = 1600,
	FrozenMaximumTime = 12,
	ThawTime = 1.2,
	Radius = 1,
	HoverHeight = 2.12,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.99 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.99 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.99 }
	}
}