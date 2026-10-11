local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2000,
	Speed = 0,
	NoCash = true,
	NoAdjustMovementAnimationSpeed = true,
	BodyHeat = 2000,
	BodyHeatRegenerationRate = 200,
	Radius = 1.1,
	AnimationTimeScale = 1,
	SpawnPathPercentage = 0.15,
	SpawnPathPercentageVariance = 0.05,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	IgnoreForWaveProgression = true,
	GhostlyUnit = true,
	KnockbackResistance = true,
	SpawnAnimationTime = 1.45,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 1 }
	},
	AbilityNames = { Enums.EnemyAbilities.MaliceZoneDeploy }
}