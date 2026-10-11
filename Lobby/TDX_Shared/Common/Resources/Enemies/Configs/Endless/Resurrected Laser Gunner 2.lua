local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 12000,
	Shield = 20000,
	Speed = 3.7,
	AnimationCalibratedSpeed = 3.7,
	BodyHeat = 5500,
	BodyHeatRegenerationRate = 250,
	OverrideDisplayName = "Resurrected Laser Gunner",
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.35 }
	}
}