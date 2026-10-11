local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 375,
	Shield = 475,
	Speed = 1.4,
	AnimationCalibratedSpeed = 1,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 50,
	OverrideDisplayName = "Lurch 2",
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	}
}