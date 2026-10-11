local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local DuckHunter = {
	Health = 1900,
	NoCash = true,
	Speed = 4,
	BodyHeat = 500,
	StealthDetection = true,
	BodyHeatRegenerationRate = 80,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AbilityNames = { Enums.EnemyAbilities.DuckHunterShotgunAttack, Enums.EnemyAbilities.DuckHunterShotgunAttackAntiAir },
	AbilityBufferTime = 2,
	DifficultyToAbilityStatOverridesMap = 0,
	FakeEnemy = false,
	DamageReductionTable = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part2Easy] = {
		[Enums.EnemyAbilities.DuckHunterShotgunAttack] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.5
		},
		[Enums.EnemyAbilities.DuckHunterShotgunAttackAntiAir] = {
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
	[Enums.EnemyAbilities.DuckHunterShotgunAttack] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 8
	},
	[Enums.EnemyAbilities.DuckHunterShotgunAttackAntiAir] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	}
}
DuckHunter.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
DuckHunter.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 }
}
return DuckHunter