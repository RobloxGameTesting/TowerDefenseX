local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Spawn 2",
	Health = 6666,
	Speed = 2.2,
	AnimationCalibratedSpeed = 2.2,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 50,
	Radius = 1,
	NoCash = true,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.95 }
	}
}