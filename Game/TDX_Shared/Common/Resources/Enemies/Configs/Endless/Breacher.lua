local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 6500,
	Shield = 3000,
	Speed = 7,
	AnimationCalibratedSpeed = 6,
	BodyHeat = 2000,
	BodyHeatRegenerationRate = 250,
	Radius = 1,
	AnimationTimeScale = 1,
	FootstepEffectInstanceNames = "Root",
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 }
	}
}