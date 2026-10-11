local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.Amalgam, Count = 7, MaxSpawnOffsetStuds = 5 }
}
return {
	Health = 12000,
	Speed = 1.2,
	BodyHeat = 3000,
	BodyHeatRegenerationRate = 400,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.LavaDeathBig,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 }
	},
	DeathSpawnData = deathSpawnData
}