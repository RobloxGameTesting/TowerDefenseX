local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Void Crystal",
	Health = 350000,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 100,
	Speed = 0,
	Radius = 1,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoHead = true,
	NoTorso = true,
	NoAnimations = true,
	StunResistance = true,
	SuperStunResistance = true,
	SpawnAnimationTime = 3.84,
	SpawnInvulnerabilityTime = 3.84,
	HasCustomCode = true,
	NoTweenOnSpawn = true,
	NoPathOffset = true,
	AbilityNames = { Enums.EnemyAbilities.VoidCrystalSpawn },
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 }
	},
	FakeEnemy = false
}