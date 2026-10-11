local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.RevivedMutatedOffspring, Count = 1, ExactPosition = true }
}
return {
	Health = 2000,
	Shield = 1000,
	Speed = 6.2,
	AnimationCalibratedSpeed = 3.8,
	BodyHeat = 350,
	BodyHeatRegenerationRate = 80,
	Radius = 1,
	HoverHeight = 1.307,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.35 }
	}
}