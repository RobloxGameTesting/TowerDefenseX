local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000,
	Speed = 2.5,
	BodyHeat = 5,
	BodyHeatRegenerationRate = 2.5,
	FrozenDebounceTime = 3.5,
	FrozenMaximumTime = 6,
	ThawTime = 1.2,
	Radius = 1,
	HoverHeight = 1.2,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.75 }
	}
}