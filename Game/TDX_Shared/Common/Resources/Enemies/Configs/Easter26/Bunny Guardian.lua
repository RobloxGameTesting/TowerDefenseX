local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local BunnyGuardian = {
	Health = 75000,
	Speed = 3.5,
	BodyHeat = 12000,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2,
	HasCustomCode = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.BunnyGuardianSwing },
	AbilityBufferTime = 2,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7,
	DifficultyToAbilityStatOverridesMap = 0,
	DamageReductionTable = 0,
	DifficultyToStatOverrideMap = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part2Easy] = {
		[Enums.EnemyAbilities.BunnyGuardianSwing] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.5
		}
	}
}
local Easter26Part2Nightmare = Enums.Difficulties.Easter26Part2Nightmare
difficultyToAbilityStatOverridesMap[Easter26Part2Nightmare] = {
	[Enums.EnemyAbilities.BunnyGuardianSwing] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 4
	}
}
BunnyGuardian.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
BunnyGuardian.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 }
}
BunnyGuardian.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.Easter26Part2Easy] = { Health = nil },
	[Enums.Difficulties.Easter26Part2Nightmare] = { Health = nil }
}
return BunnyGuardian