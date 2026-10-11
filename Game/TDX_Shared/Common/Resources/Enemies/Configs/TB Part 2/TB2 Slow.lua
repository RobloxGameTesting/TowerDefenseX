local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Slow",
	Health = 175,
	Shield = 175,
	Speed = 2,
	BodyHeat = 35,
	BodyHeatRegenerationRate = 3,
	Radius = 0.86,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Toxic, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.4 }
	}
}