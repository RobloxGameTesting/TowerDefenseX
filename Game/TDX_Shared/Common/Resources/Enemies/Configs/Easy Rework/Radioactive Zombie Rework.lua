local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Radioactive Zombie",
	Health = 2150,
	Speed = 2.9,
	BodyHeat = 800,
	BodyHeatRegenerationRate = 125,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.9,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.5 }
	}
}