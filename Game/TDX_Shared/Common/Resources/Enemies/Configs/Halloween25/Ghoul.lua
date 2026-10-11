local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 3500,
	Shield = 1000,
	Speed = 17,
	AnimationCalibratedSpeed = 16,
	BodyHeat = 1350,
	BodyHeatRegenerationRate = 150,
	Radius = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.CorruptedDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.95 }
	}
}