local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 325,
	Shield = 425,
	Speed = 1.5,
	AnimationCalibratedSpeed = 1,
	BodyHeat = 150,
	BodyHeatRegenerationRate = 40,
	OverrideDisplayName = "Lurch 1",
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	}
}