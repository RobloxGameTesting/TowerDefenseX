local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.MiniSlimeCharger, Count = 4, MaxSpawnOffsetStuds = 2 }
}
return {
	Health = 3850,
	Shield = 500,
	Speed = 7.2,
	AnimationCalibratedSpeed = 7,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 2,
	OverrideDisplayName = "Slime Charger",
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BlueGloopSmall,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.3 }
	}
}