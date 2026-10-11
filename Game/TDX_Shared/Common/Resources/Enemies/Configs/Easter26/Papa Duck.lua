local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local PapaDuck = {
	Health = 7250,
	NoCash = true,
	Speed = 3,
	BodyHeat = 2000,
	BodyHeatRegenerationRate = 320,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.8,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AbilityNames = { Enums.EnemyAbilities.PapaDuckAxeThrow, Enums.EnemyAbilities.PapaDuckAxeSpin },
	DifficultyToAbilityStatOverridesMap = 0,
	FakeEnemy = false,
	DamageReductionTable = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part2Easy] = {
		[Enums.EnemyAbilities.PapaDuckAxeThrow] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.5
		},
		[Enums.EnemyAbilities.PapaDuckAxeSpin] = {
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
	[Enums.EnemyAbilities.PapaDuckAxeThrow] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	},
	[Enums.EnemyAbilities.PapaDuckAxeSpin] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 20
	}
}
PapaDuck.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
PapaDuck.DamageReductionTable = {}
return PapaDuck