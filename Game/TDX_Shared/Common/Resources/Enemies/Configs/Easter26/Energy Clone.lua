local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local EnergyClone = {
	Health = 75000,
	Speed = 1.5,
	AnimationCalibratedSpeed = 1.7,
	BodyHeat = 80000,
	BodyHeatRegenerationRate = 40000,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	AbilityNames = {
		Enums.EnemyAbilities.EngineerMinigun,
		Enums.EnemyAbilities.EngineerSniper,
		Enums.EnemyAbilities.EngineerFistSlam,
		Enums.EnemyAbilities.EngineerToxicCloud,
		Enums.EnemyAbilities.EngineerBossHeal,
		Enums.EnemyAbilities.EngineerEMP
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DifficultyToAbilityStatOverridesMap = 0,
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = 0,
	MinimumTimeBeforeSequenceEnds = 5,
	DeathEffect = 0,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = 0,
	PlayerCountToAdditionalStatsMap = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part2Easy] = {
		[Enums.EnemyAbilities.EngineerMinigun] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = 2,
			CooldownVariance = 2,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EngineerSniper] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = 2,
			CooldownVariance = 2,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EngineerFistSlam] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = 2,
			CooldownVariance = 2,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EngineerToxicCloud] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = 2,
			CooldownVariance = 2,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EngineerBossHeal] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = 2,
			CooldownVariance = 2,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EngineerEMP] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = 2,
			CooldownVariance = 2,
			DamageMultiplier = 1
		}
	}
}
local Easter26Part2Nightmare = Enums.Difficulties.Easter26Part2Nightmare
difficultyToAbilityStatOverridesMap[Easter26Part2Nightmare] = {
	[Enums.EnemyAbilities.EngineerMinigun] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 2,
		CooldownVariance = 2,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.EngineerSniper] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 2,
		CooldownVariance = 2,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.EngineerFistSlam] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 2,
		CooldownVariance = 2,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.EngineerToxicCloud] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 2,
		CooldownVariance = 2,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.EngineerBossHeal] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 2,
		CooldownVariance = 2,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.EngineerEMP] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 2,
		CooldownVariance = 2,
		DamageMultiplier = 1
	}
}
EnergyClone.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
EnergyClone.RotationOffset = CFrame.Angles(0, 0, 0)
EnergyClone.DeathEffect = Enums.DeathEffects.BigZombieBlood
EnergyClone.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 },
	{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 }
}
EnergyClone.PlayerCountToAdditionalStatsMap = {
	[3] = { Health = 25000, Shield = 0 },
	[4] = { Health = 50000, Shield = 0 }
}
return EnergyClone