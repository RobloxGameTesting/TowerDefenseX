local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 6000,
	Shield = 2000,
	Speed = 5.7,
	BodyHeat = 2200,
	BodyHeatRegenerationRate = 200,
	Radius = 1.67,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 5.1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.75 }
	}
}