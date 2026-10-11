local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	EnemyTypeChanceMap = {
		[Enums.Enemies.TB2Normal] = 4,
		[Enums.Enemies.TB2Speed] = 3,
		[Enums.Enemies.TB2Slow] = 5,
		[Enums.Enemies.Shade] = 4,
		[Enums.Enemies.Nosowy] = 5,
		[Enums.Enemies.TB2Boss1] = 1
	},
	Count = 1,
	ExactPosition = true,
	NoCash = true
}
return {
	Health = 222,
	Speed = 8.8,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 1,
	Radius = 0.87,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 8.8,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 }
	},
	DeathSpawnData = { v }
}