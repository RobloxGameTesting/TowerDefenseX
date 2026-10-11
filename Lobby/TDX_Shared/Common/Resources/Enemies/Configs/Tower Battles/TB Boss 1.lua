local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Boss 1",
	Health = 325,
	Speed = 1.8,
	AnimationCalibratedSpeed = 1.2,
	BodyHeat = 110,
	BodyHeatRegenerationRate = 34,
	FrozenDebounceTime = 6,
	FrozenMaximumTime = 8,
	ThawTime = 1,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 }
	}
}