local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.Sludge, Count = 2, MaxSpawnOffsetStuds = 4.5 },
	{ EnemyType = Enums.Enemies.Clot, Count = 12, MaxSpawnOffsetStuds = 9 },
	{ EnemyType = Enums.Enemies.Carcin, Count = 1, MaxSpawnOffsetStuds = 1 }
}
return {
	Health = 18000,
	Shield = 3000,
	Speed = 6,
	BodyHeat = 6000,
	BodyHeatRegenerationRate = 350,
	Radius = 1.12,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 7,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DeathSpawnData = deathSpawnData,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.SludgeBossSummon },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.95 }
	}
}