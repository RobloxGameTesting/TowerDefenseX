local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.MysteryV, Count = 1, ExactPosition = true }
}
return {
	Health = 900,
	Shield = 900,
	Speed = 6.5,
	BodyHeat = 850,
	BodyHeatRegenerationRate = 120,
	Radius = 0.91,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 6.1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DeathSpawnData = deathSpawnData,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.98 }
	}
}