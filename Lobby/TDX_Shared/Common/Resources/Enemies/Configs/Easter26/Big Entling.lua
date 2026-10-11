local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local BigEntling = {
	Health = 6750,
	Shield = 2500,
	Speed = 3.2,
	BodyHeat = 350,
	BodyHeatRegenerationRate = 40,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AbilityNames = { Enums.EnemyAbilities.BigEntlingMortar, Enums.EnemyAbilities.BigEntlingMortar_PathEntity },
	DifficultyToAbilityStatOverridesMap = 0,
	FakeEnemy = false,
	DamageReductionTable = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part1Easy] = {
		[Enums.EnemyAbilities.BigEntlingMortar] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BigEntlingMortar_PathEntity] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		}
	}
}
local Easter26Part1Nightmare = Enums.Difficulties.Easter26Part1Nightmare
difficultyToAbilityStatOverridesMap[Easter26Part1Nightmare] = {
	[Enums.EnemyAbilities.BigEntlingMortar] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	},
	[Enums.EnemyAbilities.BigEntlingMortar_PathEntity] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	}
}
BigEntling.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
BigEntling.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.7 },
	{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 }
}
return BigEntling