local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.Muck, Count = 3, MaxSpawnOffsetStuds = 1 }
}
return {
	Health = 3250,
	Shield = 1500,
	Speed = 7,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 1,
	Radius = 1.16,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 6.6,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DeathSpawnData = deathSpawnData,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.95 }
	}
}