local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.TormentedSoul, Count = 20, MaxSpawnOffsetStuds = 3 }
}
return {
	Health = 19000,
	Shield = 8500,
	Speed = 3.8,
	BodyHeat = 7500,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ApostleDeath,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.2 }
	}
}