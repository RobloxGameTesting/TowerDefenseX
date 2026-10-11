local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local EasterEngineer = {
	OverrideDisplayName = "ASUS Engineer",
	Health = 175000,
	Shield = 67,
	Speed = 3,
	BodyHeat = 150000,
	BodyHeatRegenerationRate = 2500,
	Radius = 2,
	CollisionRadius = 2.2,
	AnimationTimeScale = 1,
	HasCustomCode = true,
	PreventDeathUntilAbilityExecuted = Enums.EnemyAbilities.EasterEngineerArm_WarMachine,
	InvulnerableWhilePreventingDeath = true,
	SpawnAnimationTime = 1.9669999999999999,
	SpawnInvulnerabilityTime = 1,
	IsBoss = true,
	BossMusicName = "EasterEngineerBossMusic",
	BossMusicPriorityMultiplier = 100,
	AbilityNames = {
		Enums.EnemyAbilities.EasterEngineerArm_Eradicator,
		Enums.EnemyAbilities.EasterEngineerArm_Predator,
		Enums.EnemyAbilities.EasterEngineerArm_PredatorLasers,
		Enums.EnemyAbilities.EasterEngineerArm_WarMachine,
		Enums.EnemyAbilities.EasterEngineerCloakSummon,
		Enums.EnemyAbilities.EasterEngineerCloakMG,
		Enums.EnemyAbilities.EasterEngineerCloakMG_PathEntity,
		Enums.EnemyAbilities.EasterEngineerEradShoot,
		Enums.EnemyAbilities.EasterEngineerEradShoot_PathEntity,
		Enums.EnemyAbilities.EasterEngineerEradStrafe,
		Enums.EnemyAbilities.EasterEngineerPredSummon,
		Enums.EnemyAbilities.EasterEngineerPredSummon_Slam,
		Enums.EnemyAbilities.EasterEngineerPredLaserArc,
		Enums.EnemyAbilities.EasterEngineerPredLaserBurst,
		Enums.EnemyAbilities.EasterEngineerPredLaserBurst_PathEntity,
		Enums.EnemyAbilities.EasterEngineerWMFirestorm,
		Enums.EnemyAbilities.EasterEngineerWMFlameArc,
		Enums.EnemyAbilities.EasterEngineerWMRockets_Ground,
		Enums.EnemyAbilities.EasterEngineerWMRockets_Air,
		Enums.EnemyAbilities.EasterEngineerWMRockets_PathEntity
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part2Easy] = {
		[Enums.EnemyAbilities.EasterEngineerArm_Eradicator] = { HealAmountMultiplier = 0.7 },
		[Enums.EnemyAbilities.EasterEngineerArm_Predator] = { HealAmountMultiplier = 0.65 },
		[Enums.EnemyAbilities.EasterEngineerArm_WarMachine] = { HealAmountMultiplier = 0.75 },
		[Enums.EnemyAbilities.EasterEngineerArm_PredatorLasers] = { DamageMultiplier = 0.5 },
		[Enums.EnemyAbilities.EasterEngineerCloakMG] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.8
		},
		[Enums.EnemyAbilities.EasterEngineerCloakMG_PathEntity] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EasterEngineerEradShoot] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.3
		},
		[Enums.EnemyAbilities.EasterEngineerEradShoot_PathEntity] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EasterEngineerEradStrafe] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.7
		},
		[Enums.EnemyAbilities.EasterEngineerPredSummon_Slam] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EasterEngineerPredLaserArc] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.5
		},
		[Enums.EnemyAbilities.EasterEngineerPredLaserBurst] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.8
		},
		[Enums.EnemyAbilities.EasterEngineerPredLaserBurst_PathEntity] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EasterEngineerWMFirestorm] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.7
		},
		[Enums.EnemyAbilities.EasterEngineerWMFlameArc] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.5
		},
		[Enums.EnemyAbilities.EasterEngineerWMRockets_Ground] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.EasterEngineerWMRockets_Air] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.3
		},
		[Enums.EnemyAbilities.EasterEngineerWMRockets_PathEntity] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		}
	}
}
local Easter26Part2Nightmare = Enums.Difficulties.Easter26Part2Nightmare
difficultyToAbilityStatOverridesMap[Easter26Part2Nightmare] = {
	[Enums.EnemyAbilities.EasterEngineerArm_Eradicator] = { HealAmountMultiplier = 2 },
	[Enums.EnemyAbilities.EasterEngineerArm_Predator] = { HealAmountMultiplier = 2.7 },
	[Enums.EnemyAbilities.EasterEngineerArm_WarMachine] = { HealAmountMultiplier = 3 },
	[Enums.EnemyAbilities.EasterEngineerArm_PredatorLasers] = { DamageMultiplier = 1 },
	[Enums.EnemyAbilities.EasterEngineerCloakMG] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 4
	},
	[Enums.EnemyAbilities.EasterEngineerCloakMG_PathEntity] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 8
	},
	[Enums.EnemyAbilities.EasterEngineerEradShoot] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 3
	},
	[Enums.EnemyAbilities.EasterEngineerEradShoot_PathEntity] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 9
	},
	[Enums.EnemyAbilities.EasterEngineerEradStrafe] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.EasterEngineerPredSummon_Slam] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.EasterEngineerPredLaserArc] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.EasterEngineerPredLaserBurst] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	},
	[Enums.EnemyAbilities.EasterEngineerPredLaserBurst_PathEntity] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 12
	},
	[Enums.EnemyAbilities.EasterEngineerWMFirestorm] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 3
	},
	[Enums.EnemyAbilities.EasterEngineerWMFlameArc] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	},
	[Enums.EnemyAbilities.EasterEngineerWMRockets_Ground] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	},
	[Enums.EnemyAbilities.EasterEngineerWMRockets_Air] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 8
	},
	[Enums.EnemyAbilities.EasterEngineerWMRockets_PathEntity] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 25
	}
}
local TBPart2Voidmare = Enums.Difficulties.TBPart2Voidmare
difficultyToAbilityStatOverridesMap[TBPart2Voidmare] = {
	[Enums.EnemyAbilities.EasterEngineerWMFirestorm] = { DamageMultiplier = 6 },
	[Enums.EnemyAbilities.EasterEngineerEradStrafe] = { DamageMultiplier = 1.5 },
	[Enums.EnemyAbilities.EasterEngineerEradShoot_PathEntity] = { DamageMultiplier = 1.5 },
	[Enums.EnemyAbilities.EasterEngineerEradShoot] = { DamageMultiplier = 1.5 },
	[Enums.EnemyAbilities.EasterEngineerCloakMG_PathEntity] = { DamageMultiplier = 3 },
	[Enums.EnemyAbilities.EasterEngineerCloakMG] = { DamageMultiplier = 2 }
}
EasterEngineer.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
EasterEngineer.FootstepEffectInstanceNames = "RootPart>FootstepSFX"
EasterEngineer.SetUpFootstepKeyframeReachedEventForAllAnimations = true
EasterEngineer.AttackData = {
	{
		Description = "Collision",
		IgnoreOnClient = true,
		NoStopToAttack = true,
		CanTargetAir = false,
		IgnoreGround = false,
		CanTargetBase = false,
		CanTargetBaseUsingEndNodes = false,
		PrioritizeBase = false,
		OnlyAttackBase = false,
		TargetMinimumValue = 0,
		ConsiderTargetsWithNoAttack = true,
		IsProjectile = false,
		IsSplash = false,
		Damage = 1000000,
		ReloadTime = 0.005,
		Range = 2,
		IsBurst = false
	}
}
EasterEngineer.HasAttack = true
EasterEngineer.StopToAttack = false
EasterEngineer.StealthDetection = false
EasterEngineer.RangeVariance = false
EasterEngineer.NoPathOffset = true
EasterEngineer.RotationOffset = CFrame.Angles(0, 0, 0)
EasterEngineer.MinimumTimeBeforeSequenceEnds = 5
EasterEngineer.DeathEffect = Enums.DeathEffects.BigZombieBlood
EasterEngineer.FadeOutOnDeath = true
EasterEngineer.FadeOutDelay = 1.5
EasterEngineer.FadeOutCustomTime = 0.5
EasterEngineer.FadeOutRemoveDelay = 2
EasterEngineer.DeathEffectsData = {
	{ InstancePath = "DeathEffects" },
	{ InstancePath = "Appearance>Arm_WarMachine" },
	{ InstancePath = "Death", Delay = 6.1 }
}
EasterEngineer.FakeEnemy = false
EasterEngineer.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.67 },
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 }
}
EasterEngineer.PlayerCountToAdditionalStatsMap = {
	[3] = { Health = 25000, Shield = 0 },
	[4] = { Health = 50000, Shield = 0 }
}
return EasterEngineer