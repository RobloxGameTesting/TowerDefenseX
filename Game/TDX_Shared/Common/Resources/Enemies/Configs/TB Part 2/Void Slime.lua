local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.VoidGoo, Count = 1, ExactPosition = true }
}
return {
	Health = 37500,
	Shield = 5000,
	Speed = 3.2,
	BodyHeat = 300,
	BodyHeatRegenerationRate = 25,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.55 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.25 }
	},
	DeathSpawnData = deathSpawnData
}