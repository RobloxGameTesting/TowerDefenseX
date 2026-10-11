local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Boss 3",
	Health = 4000,
	Speed = 6.5,
	AnimationCalibratedSpeed = 6,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 400,
	FrozenDebounceTime = 6,
	FrozenMaximumTime = 4,
	ThawTime = 0.6,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 }
	}
}