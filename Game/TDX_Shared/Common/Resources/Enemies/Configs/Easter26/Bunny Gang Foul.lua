local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 550,
	Shield = 200,
	Speed = 2.4,
	BodyHeat = 225,
	BodyHeatRegenerationRate = 18,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 }
	}
}