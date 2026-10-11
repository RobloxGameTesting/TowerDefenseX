local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2800,
	Speed = 1.8,
	AnimationCalibratedSpeed = 1.5,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 200,
	Radius = 1,
	HoverHeight = 1.9888000000000003,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.JudgeSpeedboost },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.1 }
	}
}