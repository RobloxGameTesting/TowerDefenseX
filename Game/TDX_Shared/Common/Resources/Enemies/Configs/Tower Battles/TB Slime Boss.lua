local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.TBSlime, Count = 6, MaxSpawnOffsetStuds = 5 }
}
return {
	OverrideDisplayName = "Slime Boss",
	Health = 1000,
	Speed = 3,
	AnimationCalibratedSpeed = 1.8,
	BodyHeat = 400,
	BodyHeatRegenerationRate = 150,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 }
	}
}