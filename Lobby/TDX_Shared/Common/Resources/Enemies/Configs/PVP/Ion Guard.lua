local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		EnemyType = Enums.Enemies.Malfunction,
		HealthMultiplier = 5,
		Count = 1,
		NoCash = true,
		ExactPosition = true,
		NoSpawnTween = true
	}
}
return {
	IsPVP = true,
	SendCost = 3200,
	BuildDuration = 6,
	UnlockWave = 23,
	SendEco = 0,
	Health = 7250,
	StunResistance = true,
	Shield = 7800,
	Speed = 2.8,
	AnimationCalibratedSpeed = 2.5,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 225,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.HumveeDeath,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.7 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.55 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.4 }
	}
}