local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Boss 4",
	Health = 18000,
	Speed = 5,
	AnimationCalibratedSpeed = 3.5,
	BodyHeat = 3000,
	BodyHeatRegenerationRate = 800,
	FrozenDebounceTime = 10,
	FrozenMaximumTime = 10,
	ThawTime = 1,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.25 }
	}
}