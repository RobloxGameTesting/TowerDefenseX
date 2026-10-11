local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 75000,
	Shield = 50000,
	Speed = 2,
	BodyHeat = 12000,
	BodyHeatRegenerationRate = 950,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.8 }
	}
}