local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local BunnyZilla = {
	Health = 500000,
	Speed = 7,
	BodyHeat = 120000,
	BodyHeatRegenerationRate = 1250,
	FrozenDebounceTime = 12,
	FrozenMaximumTime = 10,
	ThawTime = 0.6,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 7,
	HasCustomCode = true,
	IsMiniBoss = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FakeEnemy = false,
	FootstepEffectInstanceNames = "HumanoidRootPart>FootstepSFX",
	AbilityNames = {
		Enums.EnemyAbilities.BunnyZillaBurrow,
		Enums.EnemyAbilities.BunnyZillaBurrowInvulnerability,
		Enums.EnemyAbilities.BunnyZillaEmerge,
		Enums.EnemyAbilities.BunnyZillaEmergeInvulnerability,
		Enums.EnemyAbilities.BunnyZillaLaser
	},
	AbilityBufferTime = 2,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7,
	DifficultyToAbilityStatOverridesMap = 0,
	DamageReductionTable = 0,
	DifficultyToStatOverrideMap = 0,
	PlayerCountToAdditionalStatsMap = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part2Easy] = {
		[Enums.EnemyAbilities.BunnyZillaBurrow] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.5
		},
		[Enums.EnemyAbilities.BunnyZillaBurrowInvulnerability] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyZillaEmerge] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyZillaEmergeInvulnerability] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyZillaLaser] = {
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
	[Enums.EnemyAbilities.BunnyZillaBurrow] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyZillaBurrowInvulnerability] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyZillaEmerge] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyZillaEmergeInvulnerability] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyZillaLaser] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 8
	}
}
BunnyZilla.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
BunnyZilla.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
}
BunnyZilla.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.Easter26Part2Easy] = { Health = nil },
	[Enums.Difficulties.Easter26Part2Nightmare] = { Health = nil }
}
BunnyZilla.PlayerCountToAdditionalStatsMap = {
	[3] = { Health = 150000, Shield = 175000 },
	[4] = { Health = 300000, Shield = 350000 }
}
return BunnyZilla