local Schema = {
	Enemy = {
		Speed = { Type = "number", Min = 0, Max = 100 },
		Health = { Type = "number", Min = 1, Max = 1000000000 },
		Shield = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
		BodyHeat = { Type = "number", Min = 0, Max = 1000000, Optional = true },
		BodyHeatRegenerationRate = { Type = "number", Min = 0, Max = 1000000, Optional = true },
		ThawTime = {
			Type = "number",
			Min = 0,
			Max = 600,
			Optional = true,
			Note = "Default 0.8s if unset"
		},
		FrozenMaximumTime = {
			Type = "number",
			Min = 0,
			Max = 600,
			Optional = true,
			Note = "Default 4s if unset"
		},
		FrozenDebounceTime = {
			Type = "number",
			Min = 0,
			Max = 600,
			Optional = true,
			Note = "Default 3s if unset"
		},
		BaseDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
		BaseDamageOverride = { Type = "number", Min = 0, Max = 1000000, Optional = true },
		InstantLossIfReachEnd = { Type = "boolean", Optional = true },
		StunResistance = { Type = "boolean", Optional = true },
		SuperStunResistance = { Type = "boolean", Optional = true },
		StealthDetection = { Type = "boolean", Optional = true },
		KnockbackResistance = { Type = "boolean", Optional = true },
		NoCash = { Type = "boolean", Optional = true },
		AlwaysStealthed = { Type = "boolean", ReadOnly = true },
		IsBoss = { Type = "boolean", ReadOnly = true },
		IsMiniBoss = { Type = "boolean", ReadOnly = true }
	},
	EnemyAdditionalStats = {
		Health = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
		Shield = { Type = "number", Min = 0, Max = 1000000000, Optional = true }
	},
	EnemyAbilityStatOverrides = {
		Disabled = { Type = "boolean", Optional = true },
		StartingCooldown = { Type = "number", Min = 0, Max = 6000, Optional = true },
		Cooldown = { Type = "number", Min = 0, Max = 6000, Optional = true },
		StartingCooldownVariance = { Type = "number", Min = 0, Max = 6000, Optional = true },
		CooldownVariance = { Type = "number", Min = 0, Max = 6000, Optional = true },
		DamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
		HealAmountMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true }
	},
	DamageReductionValue = { Type = "percentage", Min = 0, Max = 1, Optional = true },
	EnemyDeathSpawn = {
		EnemyType = {
			Type = "enemyType",
			Optional = true,
			Note = "Takes precedence over the chance map"
		},
		Count = { Type = "integer", Min = 0, Max = 200, Note = "Spawned this many times per death" },
		Delay = { Type = "number", Min = 0, Max = 600, Optional = true },
		MaxSpawnOffsetStuds = { Type = "number", Min = 0, Max = 1000, Optional = true },
		OnlyBackwardsOffset = { Type = "boolean", Optional = true },
		PathStudsOffset = { Type = "number", Min = -1000, Max = 1000, Optional = true },
		ExactPosition = { Type = "boolean", Optional = true },
		NoSpawnTween = { Type = "boolean", Optional = true },
		NoCash = { Type = "boolean", Optional = true },
		Stealth = { Type = "boolean", Optional = true },
		StaticEntityLifetime = {
			Type = "number",
			Min = 0,
			Max = 600,
			Optional = true,
			Note = "Often matched to the static entity's VFX length"
		},
		StaticEntityType = { Type = "string", ReadOnly = true }
	},
	DeathSpawnChanceValue = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	EnemyPVP = {
		SendCost = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
		UnlockWave = { Type = "integer", Min = 0, Max = 10000, Optional = true },
		BuildDuration = { Type = "number", Min = 0, Max = 600, Optional = true },
		BuildCooldown = {
			Type = "number",
			Min = 0,
			Max = 600,
			Optional = true,
			Note = "Default 0s if unset"
		},
		PVPCashPerDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
		SendEco = { Type = "number", Min = -1000000000, Max = 1000000000, Optional = true }
	},
	Economy = {
		TickInterval = { Type = "number", Min = 0.5, Max = 600, Note = "Seconds between payouts" },
		StartingCashEco = {
			Type = "number",
			Min = 0,
			Max = 1000000000,
			Note = "Free cash per tick at match start"
		},
		IncreaseDuration = {
			Type = "number",
			Min = 0.5,
			Max = 6000,
			Note = "Seconds between ramp increases"
		},
		IncreaseAmount = {
			Type = "number",
			Min = 0,
			Max = 1000000000,
			Note = "Cash added per ramp increase"
		}
	},
	EconomyOrder = { "TickInterval", "StartingCashEco", "IncreaseDuration", "IncreaseAmount" },
	AttackData = {
		DamageType = { Type = "damageType" },
		IgnoreResistance = { Type = "boolean", Optional = true },
		Damage = { Type = "number", Min = 0, Max = 1000000000 },
		ReloadTime = { Type = "number", Min = 0, Max = 600 },
		Range = { Type = "number", Min = 0, Max = 1000 },
		MinimumRange = { Type = "number", Min = 0, Max = 1000, Optional = true },
		SplashRadius = { Type = "number", Min = 0, Max = 1000, Optional = true },
		SplashMaximumTargetsHit = { Type = "integer", Min = 0, Max = 10000, Optional = true },
		PrimaryTargetMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
		PierceCount = { Type = "integer", Min = 0, Max = 10000, Optional = true },
		PierceRange = { Type = "number", Min = 0, Max = 1000, Optional = true },
		BurstSize = { Type = "integer", Min = 0, Max = 10000, Optional = true },
		BurstInterval = { Type = "number", Min = 0, Max = 600, Optional = true },
		CanTargetAir = { Type = "boolean", Optional = true },
		AirUnitDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true }
	},
	AttackDataOrder = {
		"DamageType",
		"IgnoreResistance",
		"Damage",
		"ReloadTime",
		"Range",
		"MinimumRange",
		"SplashRadius",
		"SplashMaximumTargetsHit",
		"PrimaryTargetMultiplier",
		"PierceCount",
		"PierceRange",
		"BurstSize",
		"BurstInterval",
		"CanTargetAir",
		"AirUnitDamageMultiplier"
	},
	PathEntity = {
		Speed = { Type = "number", Min = 0, Max = 100 },
		Health = { Type = "number", Min = 1, Max = 1000000000 },
		CollisionResistance = { Type = "number", Min = 0, Max = 1000000000, Optional = true }
	},
	StaticEntity = {
		Lifetime = { Type = "number", Min = 0, Max = 6000, Optional = true }
	},
	MapEntity = {
		HasHealth = { Type = "boolean", ReadOnly = true },
		Health = {
			Type = "number",
			Min = 0,
			Max = 1000000000,
			Optional = true,
			Note = "Doubles as starting lives on maps that spawn this entity for lives"
		}
	},
	MapEntityOrder = { "HasHealth", "Health" },
	MapEntityStatOverrides = {
		Health = { Type = "number", Min = 0, Max = 1000000000, Optional = true }
	},
	MultiHealData = {
		MaximumTargets = { Type = "integer", Min = 0, Max = 10000 },
		HealAmountPerTarget = { Type = "number", Min = 0, Max = 1000000000 },
		ReloadTime = { Type = "number", Min = 0, Max = 600 },
		CanTargetParentTower = { Type = "boolean", Optional = true }
	},
	TowerBuff = {
		Type = { Type = "string", ReadOnly = true },
		IsDebuff = { Type = "boolean", ReadOnly = true },
		Percentage = { Type = "number", Min = 0, Max = 100 },
		Time = { Type = "number", Min = 0, Max = 6000 },
		DamagePerSecond = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
		DamagePercentagePerSecond = { Type = "number", Min = 0, Max = 100, Optional = true },
		HealPerSecond = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
		InstantHealAmount = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
		RemoveIfHealedForTime = { Type = "number", Min = 0, Max = 600, Optional = true },
		IgnoreStunImmunity = { Type = "boolean", Optional = true }
	},
	EnemyBuff = {
		Type = { Type = "string", ReadOnly = true },
		IsDebuff = { Type = "boolean", ReadOnly = true },
		Percentage = { Type = "number", Min = 0, Max = 100 },
		BossPercentage = { Type = "number", Min = 0, Max = 100, Optional = true },
		Time = { Type = "number", Min = 0, Max = 6000 },
		DamagePerSecond = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
		HealPerSecond = { Type = "number", Min = 0, Max = 1000000000, Optional = true }
	},
	Ability = {
		StartingCooldown = { Type = "number", Min = 0, Max = 6000 },
		Cooldown = { Type = "number", Min = 0, Max = 6000 },
		StartingCooldownVariance = { Type = "number", Min = 0, Max = 6000 },
		CooldownVariance = { Type = "number", Min = 0, Max = 6000 },
		Delay = { Type = "number", Min = 0, Max = 600, ReadOnly = true },
		ExecutionTime = { Type = "number", Min = 0, Max = 600, ReadOnly = true },
		BurstSize = { Type = "integer", Min = 1, Max = 1000, ReadOnly = true },
		BurstInterval = { Type = "number", Min = 0, Max = 600, ReadOnly = true },
		EnabledDifficulties = {
			Type = "string",
			ReadOnly = true,
			Optional = true,
			Note = "Disabled on every other difficulty. Structural; change it in the ability config"
		}
	},
	AbilityProjectileHit = {
		Damage = { Type = "number", Min = 0, Max = 1000000000 },
		DamagePercentage = { Type = "number", Min = 0, Max = 100 },
		DamageMultiplier = { Type = "number", Min = 0, Max = 1000 },
		SplashRadius = { Type = "number", Min = 0, Max = 1000 }
	},
	AbilityRangedData = {
		Range = { Type = "number", Min = 0, Max = 1000 },
		MinimumRange = { Type = "number", Min = 0, Max = 1000 },
		ArcSpreadAngle = { Type = "number", Min = 0, Max = 360 },
		MinimumTargetsInRange = { Type = "integer", Min = 0, Max = 1000 },
		TargetMinimumValue = { Type = "number", Min = 0, Max = 1000000000 },
		HitAllTargetsInRange = { Type = "boolean", ReadOnly = true },
		TargetMostExpensiveTower = { Type = "boolean", ReadOnly = true },
		TargetWeakestTower = { Type = "boolean", ReadOnly = true },
		TargetRandomTower = { Type = "boolean", ReadOnly = true },
		TargetHighestRangeTower = { Type = "boolean", ReadOnly = true }
	},
	AbilityDamageData = {
		Damage = { Type = "number", Min = 0, Max = 1000000000 },
		DamagePercentage = { Type = "number", Min = 0, Max = 1 },
		InstantKill = { Type = "boolean" }
	},
	AbilityDamageFalloff = {
		Range = { Type = "number", Min = 0, Max = 1000 },
		Damage = { Type = "number", Min = 0, Max = 1000000000 }
	},
	AbilityRadiusEffect = {
		MinimumRange = { Type = "number", Min = 0, Max = 1000 },
		MaximumRange = { Type = "number", Min = 0, Max = 1000 },
		HitPercentage = { Type = "number", Min = 0, Max = 1 },
		MinimumTargets = { Type = "integer", Min = 0, Max = 1000 },
		MaximumTargets = { Type = "integer", Min = 0, Max = 1000 }
	},
	AbilityTowerInstantKill = {
		InstantKillType = { Type = "string", ReadOnly = true },
		TowerType = { Type = "string", ReadOnly = true, Optional = true },
		TargetEMPVulnerableUnits = { Type = "boolean", ReadOnly = true, Optional = true },
		Count = { Type = "number", Min = 0, Max = 1000000000 }
	},
	AbilityEnemyRangedData = {
		Range = { Type = "number", Min = 0, Max = 1000 },
		MinimumRange = { Type = "number", Min = 0, Max = 1000 }
	},
	AbilityMapEntityRanged = {
		Range = { Type = "number", Min = 0, Max = 1000 },
		MinimumRange = { Type = "number", Min = 0, Max = 1000 },
		Damage = { Type = "number", Min = 0, Max = 1000000000 }
	},
	AbilityHealData = {
		OverrideMaxHealth = { Type = "number", Min = 0, Max = 1000000000 },
		OverrideMaxShield = { Type = "number", Min = 0, Max = 1000000000 },
		HealAmount = { Type = "number", Min = 0, Max = 1000000000 },
		ShieldGain = { Type = "number", Min = 0, Max = 1000000000 },
		ShieldCap = { Type = "number", Min = 0, Max = 1000000000 },
		ShieldGainPercentageOfTargetMaxHealth = { Type = "number", Min = 0, Max = 1 },
		Delay = { Type = "number", Min = 0, Max = 600 }
	},
	AbilityDamageBaseData = {
		Damage = { Type = "number", Min = 0, Max = 1000000000 },
		InstantLoss = { Type = "boolean" }
	},
	AbilityCloneData = {
		Radius = { Type = "number", Min = 0, Max = 1000 },
		Multiplier = { Type = "integer", Min = 0, Max = 100 },
		MaxSpawnOffsetStuds = {
			Type = "number",
			Min = 0,
			Max = 1000,
			Note = "Spawns within this many studs of the spawner, along the path"
		},
		SpeedBoostMultiplier = { Type = "number", Min = 0, Max = 100 },
		EvenlyDistribute = { Type = "boolean" },
		FavorSpawningBehindParent = {
			Type = "boolean",
			Note = "Biases the offset backwards along the path"
		},
		IgnoreBoss = { Type = "boolean" },
		NoCash = { Type = "boolean" },
		FullHealth = { Type = "boolean" }
	},
	AbilityTimeManipulation = {
		SpeedMultiplier = { Type = "number", Min = 0, Max = 100 },
		Duration = { Type = "number", Min = 0, Max = 600 }
	},
	AbilitySpawnEnemy = {
		EnemyType = { Type = "enemyType" },
		Count = { Type = "integer", Min = 0, Max = 10000 },
		SpawnDelay = { Type = "number", Min = 0, Max = 600 },
		StaggerMaxDelay = { Type = "number", Min = 0, Max = 600 },
		MaxSpawnOffsetStuds = {
			Type = "number",
			Min = -1000,
			Max = 1000,
			Optional = true,
			Note = "Spawns within this many studs of the spawner, along the path"
		},
		MinimumSpawnOffsetStuds = {
			Type = "number",
			Min = -1000,
			Max = 1000,
			Optional = true,
			Note = "Keeps spawns at least this far from the spawner; overrides the two Favor options"
		},
		FavorSpawningBehindParent = {
			Type = "boolean",
			Optional = true,
			Note = "Biases the offset backwards along the path"
		},
		FavorSpawningInFrontOfParent = {
			Type = "boolean",
			Optional = true,
			Note = "Biases the offset forwards along the path"
		},
		PathPercentageLowerBound = {
			Type = "number",
			Min = 0,
			Max = 1,
			Optional = true,
			Note = "Earliest point on the path a spawn can appear (0 = start)"
		},
		PathPercentageUpperBound = {
			Type = "number",
			Min = 0,
			Max = 1,
			Optional = true,
			Note = "Latest point on the path a spawn can appear (1 = exit)"
		},
		HealthMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
		ShieldMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
		AbilityDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
		SpeedBoostMultiplier = { Type = "number", Min = 0, Max = 100, Optional = true },
		Stealth = { Type = "boolean" },
		NoCash = { Type = "boolean" }
	},
	AbilitySpawnEnemyOrder = {
		"EnemyType",
		"Count",
		"SpawnDelay",
		"StaggerMaxDelay",
		"MinimumSpawnOffsetStuds",
		"MaxSpawnOffsetStuds",
		"FavorSpawningBehindParent",
		"FavorSpawningInFrontOfParent",
		"PathPercentageLowerBound",
		"PathPercentageUpperBound",
		"Stealth",
		"NoCash",
		"HealthMultiplier",
		"ShieldMultiplier",
		"AbilityDamageMultiplier",
		"SpeedBoostMultiplier"
	},
	AbilityBombardmentAttack = {
		SpawnDistance = { Type = "number", Min = 0, Max = 10000 },
		SpawnHeight = { Type = "number", Min = 0, Max = 10000 },
		SpawnVarianceXZ = { Type = "number", Min = 0, Max = 1000 },
		SpawnVarianceY = { Type = "number", Min = 0, Max = 1000 },
		SpawnAngleFromParallel = { Type = "number", Min = -360, Max = 360 },
		TargetGroundAroundEnemyRadius = { Type = "number", Min = 0, Max = 1000 },
		TargetGroundMaximumHeightDelta = { Type = "number", Min = 0, Max = 1000 },
		TargetTowerMinimumRange = { Type = "number", Min = 0, Max = 1000 },
		TargetTowerMinimumValue = { Type = "number", Min = 0, Max = 1000000000 },
		Delay = { Type = "number", Min = 0, Max = 600 },
		Duration = { Type = "number", Min = 0, Max = 600 },
		Count = { Type = "integer", Min = 0, Max = 10000 },
		Damage = { Type = "number", Min = 0, Max = 1000000000 },
		SplashRadius = { Type = "number", Min = 0, Max = 1000 },
		TargetRandomTower = { Type = "boolean" },
		CanTargetAir = { Type = "boolean" },
		IgnoreGround = { Type = "boolean" },
		SplashAlwaysHitAirAndGround = { Type = "boolean" }
	}
}
local damageData = {
	Field = "DamageData",
	Fields = Schema.AbilityDamageData,
	Children = {
		DamageFalloffRanges = {
			Field = "DamageFalloffRanges",
			List = true,
			Fields = Schema.AbilityDamageFalloff
		}
	}
}
Schema.AbilityShape = {
	Fields = Schema.Ability,
	Children = {
		ProjectileHitData = { Field = "ProjectileHitData", Fields = Schema.AbilityProjectileHit },
		RangedSequence = {
			Field = "EnemyToTowerRangedDataSequence",
			List = true,
			Fields = Schema.AbilityRangedData,
			Children = { DamageData = damageData }
		},
		RadiusEffect = {
			Field = "EnemyToTowerRadiusEffectData",
			Fields = Schema.AbilityRadiusEffect,
			Children = {
				DamageData = damageData,
				TowerInstantKill = {
					Field = "TowerInstantKillData",
					List = true,
					Fields = Schema.AbilityTowerInstantKill
				}
			}
		},
		EnemyToEnemyRanged = {
			Field = "EnemyToEnemyRangedData",
			Fields = Schema.AbilityEnemyRangedData,
			Children = {
				HealData = { Field = "HealData", Fields = Schema.AbilityHealData }
			}
		},
		EnemyToEnemyRadius = {
			Field = "EnemyToEnemyRadiusEffectData",
			Fields = Schema.AbilityRadiusEffect,
			Children = {
				HealData = { Field = "HealData", Fields = Schema.AbilityHealData }
			}
		},
		MapEntityRanged = {
			Field = "EnemyToMapEntityRangedData",
			Fields = Schema.AbilityMapEntityRanged
		},
		HealData = { Field = "HealData", Fields = Schema.AbilityHealData },
		DamageBaseData = { Field = "DamageBaseData", Fields = Schema.AbilityDamageBaseData },
		EnemyCloneData = { Field = "EnemyCloneData", Fields = Schema.AbilityCloneData },
		TimeManipulationData = {
			Field = "TimeManipulationData",
			Fields = Schema.AbilityTimeManipulation
		},
		SpawnEnemies = {
			Field = "SpawnEnemies",
			List = true,
			Fields = Schema.AbilitySpawnEnemy,
			Editable = true,
			Finalize = function(state)
				if typeof(state.EnemyType) ~= "string" then
					return "needs a valid EnemyType"
				end

				state.Count = state.Count or 1

				if not (state.MaxSpawnOffsetStuds or state.PathPercentageLowerBound and state.PathPercentageUpperBound) then
					state.MaxSpawnOffsetStuds = 10
				end

				return nil
			end
		},
		BombardmentData = {
			Field = "BombardmentData",
			Children = {
				Attacks = {
					Field = "Attacks",
					List = true,
					Fields = Schema.AbilityBombardmentAttack
				}
			}
		}
	}
}
Schema.PathEntityAbilityRanged = {
	CanTargetAir = { Type = "boolean", Optional = true },
	Range = { Type = "number", Min = 0, Max = 1000 },
	MinimumRange = { Type = "number", Min = 0, Max = 1000, Optional = true },
	Damage = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	DamageType = { Type = "damageType", Optional = true }
}
Schema.PathEntityAbilityRadius = {
	MinimumRange = { Type = "number", Min = 0, Max = 1000, Optional = true },
	MaximumRange = { Type = "number", Min = 0, Max = 1000, Optional = true },
	HitPercentage = { Type = "number", Min = 0, Max = 1, Optional = true },
	MinimumTargets = { Type = "integer", Min = 0, Max = 1000, Optional = true },
	MaximumTargets = { Type = "integer", Min = 0, Max = 1000, Optional = true },
	Damage = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	DamageType = { Type = "damageType", Optional = true }
}
Schema.PathEntityAbilitySpawn = {
	PathEntityType = { Type = "pathEntityType" },
	Count = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	SpawnDelay = { Type = "number", Min = 0, Max = 600, Optional = true },
	StaggerMaxDelay = { Type = "number", Min = 0, Max = 600, Optional = true },
	MaxSpawnOffsetStuds = { Type = "number", Min = 0, Max = 1000, Optional = true },
	FavorSpawningBehindParent = { Type = "boolean", Optional = true },
	FavorSpawningInFrontOfParent = { Type = "boolean", Optional = true },
	PathPercentageLowerBound = { Type = "number", Min = 0, Max = 1, Optional = true },
	PathPercentageUpperBound = { Type = "number", Min = 0, Max = 1, Optional = true }
}

function Schema.SpawnPathEntitiesNode(field: string)
	return {
		Field = field,
		List = true,
		Fields = Schema.PathEntityAbilitySpawn,
		Editable = true,
		Finalize = function(state, list)
			if typeof(state.PathEntityType) ~= "string" then
				return "needs a valid PathEntityType"
			end

			state.Count = state.Count or 1

			if not (state.MaxSpawnOffsetStuds or state.PathPercentageLowerBound and state.PathPercentageUpperBound) then
				state.MaxSpawnOffsetStuds = 10
			end

			local v = list[1]

			if v then
				state.Summoned = v.Summoned
				state.SummonedVFXName = v.SummonedVFXName
			end

			return nil
		end
	}
end

Schema.PathEntityAbilityShape = {
	Fields = Schema.Ability,
	Children = {
		RangedData = {
			Field = "PathEntityToEnemyRangedData",
			Fields = Schema.PathEntityAbilityRanged
		},
		RadiusEffect = {
			Field = "PathEntityToEnemyRadiusEffectData",
			Fields = Schema.PathEntityAbilityRadius
		},
		SpawnPathEntities = Schema.SpawnPathEntitiesNode("SpawnPathEntities")
	}
}
Schema.TowerLimitValue = { Type = "integer", Min = 1, Max = 10000 }
Schema.TowerCoreBase = { "Cost", "Health", "Damage", "ReloadTime", "Range" }
Schema.TowerCoreUpgrade = {
	"Cost",
	"DamageIncrease",
	"ReloadTimeDecrease",
	"RangeIncrease",
	"HealthIncrease"
}
Schema.TowerForcedUpgradeFields = {
	MLRS = { "GainSplashAlwaysHitAirAndGround", "GainCanTargetAir" }
}
Schema.TowerTop = {
	PathLockLevel = { Type = "integer", Min = 0, Max = 5, ReadOnly = true },
	OnePathOnly = { Type = "boolean", ReadOnly = true }
}
Schema.TowerConfigTop = {
	EMPVulnerable = { Type = "boolean", Optional = true, Note = "Applies to newly placed towers" }
}
Schema.TowerBaseStats = {
	Cost = { Type = "integer", Min = 0, Max = 1000000000 },
	Health = { Type = "number", Min = 0, Max = 1000000000 },
	Untargetable = { Type = "boolean", Optional = true },
	CanRebuild = { Type = "boolean", Optional = true },
	RebuildTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	RebuildTimeIncreaseEachDeath = { Type = "number", Min = 0, Max = 600, Optional = true },
	HasDirectControl = { Type = "boolean", Optional = true },
	DirectControlMagSize = { Type = "integer", Min = 0, Max = 100000, Optional = true },
	DirectControlReloadTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	PierceCount = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	CanTargetAir = { Type = "boolean", Optional = true },
	StaticEntityLifetime = { Type = "number", Min = 0, Max = 6000, Optional = true },
	IgnoreGround = { Type = "boolean", Optional = true },
	IsSplash = { Type = "boolean", Optional = true },
	SplashRadius = { Type = "number", Min = 0, Max = 1000, Optional = true },
	SplashAlwaysHitAirAndGround = { Type = "boolean", Optional = true },
	SplashMaximumTargetsHit = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	PrimaryTargetMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
	AimTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	AimResetTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	IgnoreResistance = { Type = "boolean", Optional = true },
	IgnoreObstacles = { Type = "boolean", Optional = true },
	DamageType = { Type = "damageType" },
	Damage = { Type = "number", Min = 0, Max = 1000000000 },
	DamageDelay = { Type = "number", Min = 0, Max = 600, Optional = true },
	HealAmount = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	ReloadTime = { Type = "number", Min = 0, Max = 600 },
	Range = { Type = "number", Min = 0, Max = 1000 },
	MinRange = { Type = "number", Min = 0, Max = 1000, Optional = true },
	StealthDetection = { Type = "boolean" },
	StunImmunity = { Type = "boolean", Optional = true },
	MovementSpeed = { Type = "number", Min = 0, Max = 1000, Optional = true },
	DamageIncreaseOverTimeMaxMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
	DamageIncreaseOverTimeDuration = { Type = "number", Min = 0, Max = 600, Optional = true },
	DamageIncreaseOverTimeCooldown = { Type = "number", Min = 0, Max = 600, Optional = true },
	DamageIncreasePerSecond = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	MaximumROM = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	ChainCount = { Type = "integer", Min = 0, Max = 1000, Optional = true },
	ChainMaxDistance = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ChainDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
	Stealth = { Type = "boolean", Optional = true },
	BodyHeatReduction = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	PermanentSpeedMultiplierIfFrozen = { Type = "number", Min = 0, Max = 100, Optional = true },
	DamageMultiplierIfFrozen = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ThawTimeIfFrozen = { Type = "number", Min = 0, Max = 600, Optional = true },
	IgnoreIceResistance = { Type = "boolean", Optional = true },
	CanFreezeBoss = { Type = "boolean", Optional = true },
	FrozenEnemyDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
	NearbyTowerFirerateBuff = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerRangeBuff = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerDamageBuff = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerDiscount = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerSellback = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerDeathCashback = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerHealPerSecond = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	ShieldSharedGrant = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	ShieldDirectGrant = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	ShieldGrantRefreshTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	CashPerWave = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	CashPerCompletedBurst = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	CashPerTick = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	CashTickDuration = { Type = "number", Min = 0, Max = 600, Optional = true },
	CashPerDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
	GoldWinBonus = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	ReviveDuration = { Type = "number", Min = 0, Max = 600, Optional = true },
	SlowSpeed = { Type = "number", Min = 0, Max = 100, Optional = true },
	BossSlowSpeed = { Type = "number", Min = 0, Max = 100, Optional = true },
	StunDuration = { Type = "number", Min = 0, Max = 600, Optional = true },
	CanStunBoss = { Type = "boolean", Optional = true },
	ExtraDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ExtraDamageMultiplierBoss = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ExtraDamageDuration = { Type = "number", Min = 0, Max = 600, Optional = true },
	SlowdownPercentage = { Type = "number", Min = 0, Max = 100, Optional = true },
	SlowdownDuration = { Type = "number", Min = 0, Max = 600, Optional = true },
	KnockbackStuds = { Type = "number", Min = 0, Max = 1000, Optional = true },
	KnockbackHeight = { Type = "number", Min = 0, Max = 1000, Optional = true },
	KnockbackSuspendTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	BurstSize = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	BurstInterval = { Type = "number", Min = 0, Max = 600, Optional = true },
	BaitEnemyAttacks = { Type = "boolean", Optional = true },
	ArcSpreadAngle = { Type = "number", Min = 0, Max = 360, Optional = true },
	ArcMaximumTargetsHit = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	AirUnitDamageMultiplier = { Type = "number", Min = 0, Max = 1000, Optional = true }
}
Schema.TowerBaseStatsOrder = {
	"Cost",
	"Health",
	"Untargetable",
	"CanRebuild",
	"RebuildTime",
	"RebuildTimeIncreaseEachDeath",
	"HasDirectControl",
	"DirectControlMagSize",
	"DirectControlReloadTime",
	"PierceCount",
	"CanTargetAir",
	"StaticEntityLifetime",
	"IgnoreGround",
	"IsSplash",
	"SplashRadius",
	"SplashAlwaysHitAirAndGround",
	"SplashMaximumTargetsHit",
	"PrimaryTargetMultiplier",
	"AimTime",
	"AimResetTime",
	"IgnoreResistance",
	"IgnoreObstacles",
	"DamageType",
	"Damage",
	"DamageDelay",
	"HealAmount",
	"ReloadTime",
	"Range",
	"MinRange",
	"StealthDetection",
	"StunImmunity",
	"MovementSpeed",
	"DamageIncreaseOverTimeMaxMultiplier",
	"DamageIncreaseOverTimeDuration",
	"DamageIncreaseOverTimeCooldown",
	"DamageIncreasePerSecond",
	"MaximumROM",
	"ChainCount",
	"ChainMaxDistance",
	"ChainDamageMultiplier",
	"Stealth",
	"BodyHeatReduction",
	"PermanentSpeedMultiplierIfFrozen",
	"DamageMultiplierIfFrozen",
	"ThawTimeIfFrozen",
	"IgnoreIceResistance",
	"CanFreezeBoss",
	"FrozenEnemyDamageMultiplier",
	"NearbyTowerFirerateBuff",
	"NearbyTowerRangeBuff",
	"NearbyTowerDamageBuff",
	"NearbyTowerDiscount",
	"NearbyTowerSellback",
	"NearbyTowerDeathCashback",
	"NearbyTowerHealPerSecond",
	"ShieldSharedGrant",
	"ShieldDirectGrant",
	"ShieldGrantRefreshTime",
	"CashPerWave",
	"CashPerCompletedBurst",
	"CashPerTick",
	"CashTickDuration",
	"CashPerDamageMultiplier",
	"GoldWinBonus",
	"ReviveDuration",
	"SlowSpeed",
	"BossSlowSpeed",
	"StunDuration",
	"CanStunBoss",
	"ExtraDamageMultiplier",
	"ExtraDamageMultiplierBoss",
	"ExtraDamageDuration",
	"SlowdownPercentage",
	"SlowdownDuration",
	"KnockbackStuds",
	"KnockbackHeight",
	"KnockbackSuspendTime",
	"BurstSize",
	"BurstInterval",
	"BaitEnemyAttacks",
	"ArcSpreadAngle",
	"ArcMaximumTargetsHit",
	"AirUnitDamageMultiplier"
}
Schema.TowerUpgradeStats = {
	Cost = { Type = "integer", Min = 0, Max = 1000000000, Optional = true },
	DynamicPriceScaling = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	HasDirectControl = { Type = "boolean", Optional = true },
	DirectControlMagSizeIncrease = { Type = "integer", Min = 0, Max = 100000, Optional = true },
	DirectControlMagSizeOverride = { Type = "integer", Min = 0, Max = 100000, Optional = true },
	DirectControlReloadTimeDecrease = { Type = "number", Min = 0, Max = 600, Optional = true },
	DirectControlReloadTimeOverride = { Type = "number", Min = 0, Max = 600, Optional = true },
	HealthIncrease = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	GainUntargetable = { Type = "boolean", Optional = true },
	PierceCountIncrease = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	GainCanTargetAir = { Type = "boolean", Optional = true },
	StaticEntityLifetimeIncrease = { Type = "number", Min = 0, Max = 600, Optional = true },
	SplashRadiusIncrease = { Type = "number", Min = -1000, Max = 1000, Optional = true },
	RemoveSplash = { Type = "boolean", Optional = true },
	GainSplashAlwaysHitAirAndGround = { Type = "boolean", Optional = true },
	SplashMaximumTargetsHitIncrease = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	SplashMaximumTargetsHitOverride = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	PrimaryTargetMultiplierOverride = { Type = "number", Min = 0, Max = 1000, Optional = true },
	AimTimeOverride = { Type = "number", Min = 0, Max = 600, Optional = true },
	AimResetTimeOverride = { Type = "number", Min = 0, Max = 600, Optional = true },
	GainIgnoreObstacles = { Type = "boolean", Optional = true },
	GainIgnoreResistance = { Type = "boolean", Optional = true },
	RemoveIgnoreResistance = { Type = "boolean", Optional = true },
	DamageType = { Type = "damageType", Optional = true },
	DamageIncrease = { Type = "number", Min = -1000000000, Max = 1000000000, Optional = true },
	DamageDelayOverride = { Type = "number", Min = 0, Max = 600, Optional = true },
	HealAmountIncrease = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	ReloadTimeDecrease = { Type = "number", Min = -600, Max = 600, Optional = true },
	RangeIncrease = { Type = "number", Min = -1000, Max = 1000, Optional = true },
	MinRangeOverride = { Type = "number", Min = 0, Max = 1000, Optional = true },
	GainStealthDetection = { Type = "boolean", Optional = true },
	GainStunImmunity = { Type = "boolean", Optional = true },
	MovementSpeedIncrease = { Type = "number", Min = 0, Max = 1000, Optional = true },
	DamageIncreaseOverTimeMaxMultiplierOverride = {
		Type = "number",
		Min = 0,
		Max = 1000,
		Optional = true
	},
	DamageIncreaseOverTimeDurationOverride = {
		Type = "number",
		Min = 0,
		Max = 600,
		Optional = true
	},
	DamageIncreaseOverTimeCooldownOverride = {
		Type = "number",
		Min = 0,
		Max = 600,
		Optional = true
	},
	DamageIncreasePerSecondOverride = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	MaximumROMIncrease = { Type = "number", Min = -1000000, Max = 1000000, Optional = true },
	MaximumROMOverride = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	RemoveMaximumROM = { Type = "boolean", Optional = true },
	ChainCountIncrease = { Type = "integer", Min = 0, Max = 1000, Optional = true },
	ChainMaxDistanceIncrease = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ChainDamageMultiplierIncrease = { Type = "number", Min = 0, Max = 1000, Optional = true },
	GainStealth = { Type = "boolean", Optional = true },
	TimeToRegainStealthOverride = { Type = "number", Min = 0, Max = 600, Optional = true },
	BodyHeatReductionIncrease = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	PermanentSpeedMultiplierIfFrozenIncrease = {
		Type = "number",
		Min = -100,
		Max = 100,
		Optional = true
	},
	DamageMultiplierIfFrozenIncrease = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ThawTimeIfFrozenIncrease = { Type = "number", Min = 0, Max = 600, Optional = true },
	IgnoreIceResistance = { Type = "boolean", Optional = true },
	CanFreezeBoss = { Type = "boolean", Optional = true },
	FrozenEnemyDamageMultiplierIncrease = { Type = "number", Min = 0, Max = 1000, Optional = true },
	NearbyTowerFirerateBuffIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerRangeBuffIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerDamageBuffIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerDiscountIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerSellbackIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerDeathCashbackIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	NearbyTowerHealPerSecondIncrease = {
		Type = "number",
		Min = 0,
		Max = 1000000000,
		Optional = true
	},
	ReviveDurationDecrease = { Type = "number", Min = 0, Max = 600, Optional = true },
	ShieldSharedGrantIncrease = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	ShieldSharedGrantRemove = { Type = "boolean", Optional = true },
	ShieldDirectGrantIncrease = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	ShieldGrantRefreshTimeDecrease = { Type = "number", Min = 0, Max = 600, Optional = true },
	CashPerWaveIncrease = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	CashPerCompletedBurstIncrease = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	CashPerTickOverride = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	CashTickDurationOverride = { Type = "number", Min = 0, Max = 600, Optional = true },
	CashPerDamageMultiplierIncrease = { Type = "number", Min = 0, Max = 1000, Optional = true },
	GoldWinBonusOverride = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	SlowSpeedIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	MiniBossSlowSpeedIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	StunDurationIncrease = { Type = "number", Min = 0, Max = 600, Optional = true },
	GainCanStunBoss = { Type = "boolean", Optional = true },
	ExtraDamageMultiplierIncrease = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ExtraDamageMultiplierBossIncrease = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ExtraDamageDurationIncrease = { Type = "number", Min = 0, Max = 600, Optional = true },
	SlowdownPercentageIncrease = { Type = "number", Min = 0, Max = 100, Optional = true },
	SlowdownDurationIncrease = { Type = "number", Min = 0, Max = 600, Optional = true },
	KnockbackStudsOverride = { Type = "number", Min = 0, Max = 1000, Optional = true },
	KnockbackSuspendTimeOverride = { Type = "number", Min = 0, Max = 600, Optional = true },
	ReduceSpawnPathEntityInterval = { Type = "number", Min = 0, Max = 600, Optional = true },
	BurstSizeIncrease = { Type = "integer", Min = -10000, Max = 10000, Optional = true },
	BurstSizeOverride = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	BurstIntervalOverride = { Type = "number", Min = 0, Max = 600, Optional = true },
	RemoveBurst = { Type = "boolean", Optional = true },
	BaitEnemyAttacks = { Type = "boolean", Optional = true },
	ArcSpreadAngleIncrease = { Type = "number", Min = -360, Max = 360, Optional = true },
	ArcMaximumTargetsHitIncrease = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	DisableManualAiming = { Type = "boolean", Optional = true },
	OverrideReloadTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	OverrideBodyHeatReduction = { Type = "number", Min = 0, Max = 1000000, Optional = true }
}
Schema.TowerUpgradeStatsOrder = {
	"Cost",
	"DynamicPriceScaling",
	"HasDirectControl",
	"DirectControlMagSizeIncrease",
	"DirectControlMagSizeOverride",
	"DirectControlReloadTimeDecrease",
	"DirectControlReloadTimeOverride",
	"HealthIncrease",
	"GainUntargetable",
	"PierceCountIncrease",
	"GainCanTargetAir",
	"StaticEntityLifetimeIncrease",
	"SplashRadiusIncrease",
	"RemoveSplash",
	"GainSplashAlwaysHitAirAndGround",
	"SplashMaximumTargetsHitIncrease",
	"SplashMaximumTargetsHitOverride",
	"PrimaryTargetMultiplierOverride",
	"AimTimeOverride",
	"AimResetTimeOverride",
	"GainIgnoreObstacles",
	"GainIgnoreResistance",
	"RemoveIgnoreResistance",
	"DamageType",
	"DamageIncrease",
	"DamageDelayOverride",
	"HealAmountIncrease",
	"ReloadTimeDecrease",
	"RangeIncrease",
	"MinRangeOverride",
	"GainStealthDetection",
	"GainStunImmunity",
	"MovementSpeedIncrease",
	"DamageIncreaseOverTimeMaxMultiplierOverride",
	"DamageIncreaseOverTimeDurationOverride",
	"DamageIncreaseOverTimeCooldownOverride",
	"DamageIncreasePerSecondOverride",
	"MaximumROMIncrease",
	"MaximumROMOverride",
	"RemoveMaximumROM",
	"ChainCountIncrease",
	"ChainMaxDistanceIncrease",
	"ChainDamageMultiplierIncrease",
	"GainStealth",
	"TimeToRegainStealthOverride",
	"BodyHeatReductionIncrease",
	"PermanentSpeedMultiplierIfFrozenIncrease",
	"DamageMultiplierIfFrozenIncrease",
	"ThawTimeIfFrozenIncrease",
	"IgnoreIceResistance",
	"CanFreezeBoss",
	"FrozenEnemyDamageMultiplierIncrease",
	"NearbyTowerFirerateBuffIncrease",
	"NearbyTowerRangeBuffIncrease",
	"NearbyTowerDamageBuffIncrease",
	"NearbyTowerDiscountIncrease",
	"NearbyTowerSellbackIncrease",
	"NearbyTowerDeathCashbackIncrease",
	"NearbyTowerHealPerSecondIncrease",
	"ReviveDurationDecrease",
	"ShieldSharedGrantIncrease",
	"ShieldSharedGrantRemove",
	"ShieldDirectGrantIncrease",
	"ShieldGrantRefreshTimeDecrease",
	"CashPerWaveIncrease",
	"CashPerCompletedBurstIncrease",
	"CashPerTickOverride",
	"CashTickDurationOverride",
	"CashPerDamageMultiplierIncrease",
	"GoldWinBonusOverride",
	"SlowSpeedIncrease",
	"MiniBossSlowSpeedIncrease",
	"StunDurationIncrease",
	"GainCanStunBoss",
	"ExtraDamageMultiplierIncrease",
	"ExtraDamageMultiplierBossIncrease",
	"ExtraDamageDurationIncrease",
	"SlowdownPercentageIncrease",
	"SlowdownDurationIncrease",
	"KnockbackStudsOverride",
	"KnockbackSuspendTimeOverride",
	"BurstSizeIncrease",
	"BurstSizeOverride",
	"BurstIntervalOverride",
	"RemoveBurst",
	"BaitEnemyAttacks",
	"ArcSpreadAngleIncrease",
	"ArcMaximumTargetsHitIncrease",
	"DisableManualAiming",
	"ReduceSpawnPathEntityInterval",
	"OverrideReloadTime",
	"OverrideBodyHeatReduction"
}
Schema.SpawnPathEntity = {
	PathEntityType = { Type = "pathEntityType" },
	StartDelay = { Type = "number", Min = 0, Max = 600 },
	Interval = { Type = "number", Min = 0, Max = 600 },
	MaximumCount = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	BurstSize = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	BurstInterval = { Type = "number", Min = 0, Max = 600, Optional = true },
	SpawnAtPathPercentage = { Type = "number", Min = 0, Max = 1, Optional = true },
	SpawnNearParentTower = { Type = "boolean", Optional = true },
	IgnoreDespawnOnParentDeath = { Type = "boolean", Optional = true },
	SpawnAsSummoned = { Type = "boolean", Optional = true }
}
Schema.SpawnRemoveName = { Type = "pathEntityType" }
Schema.SpawnPathEntityOrder = {
	"PathEntityType",
	"StartDelay",
	"Interval",
	"MaximumCount",
	"BurstSize",
	"BurstInterval",
	"SpawnAtPathPercentage",
	"SpawnNearParentTower",
	"IgnoreDespawnOnParentDeath",
	"SpawnAsSummoned"
}
Schema.TowerBurnEffect = {
	Name = { Type = "string", ReadOnly = true },
	DamageType = { Type = "damageType" },
	DamagePerSecond = { Type = "number", Min = 0, Max = 1000000000 },
	Radius = { Type = "number", Min = 0, Max = 1000 },
	Duration = { Type = "number", Min = 0, Max = 600 },
	StickDuration = { Type = "number", Min = 0, Max = 600 },
	MaximumTargetsHit = { Type = "integer", Min = 0, Max = 10000, Optional = true }
}
Schema.TowerBurnEffectOrder = {
	"Name",
	"DamageType",
	"DamagePerSecond",
	"Radius",
	"Duration",
	"StickDuration",
	"MaximumTargetsHit"
}
Schema.TowerApplyBurn = {
	DamagePerSecond = { Type = "number", Min = 0, Max = 1000000000 },
	StickDuration = { Type = "number", Min = 0, Max = 600 }
}
Schema.TowerApplyBurnOrder = { "DamagePerSecond", "StickDuration" }
Schema.TowerAbility = {
	StartingCooldown = { Type = "number", Min = 0, Max = 6000 },
	Cooldown = { Type = "number", Min = 0, Max = 6000 },
	Delay = { Type = "number", Min = 0, Max = 600, ReadOnly = true },
	ExecutionTime = { Type = "number", Min = 0, Max = 600, ReadOnly = true },
	BurstSize = { Type = "integer", Min = 1, Max = 1000, ReadOnly = true },
	BurstInterval = { Type = "number", Min = 0, Max = 600, ReadOnly = true },
	ContinuousForTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	ContinuousReloadTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	EffectRadius = { Type = "number", Min = 0, Max = 1000, Optional = true },
	RadiusDamage = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	RadiusDamageMaximumTargets = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	HealPercentage = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	HealAmount = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	BodyHeatReduction = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	EnemyDamage = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	RevealTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	TowerBuffOverrideTime = { Type = "number", Min = 0, Max = 6000, Optional = true },
	EnableTowerAttackDuration = { Type = "number", Min = 0, Max = 600, Optional = true },
	CannotUseAfterAttackForSeconds = { Type = "number", Min = 0, Max = 600, Optional = true },
	ManualAimCustomRange = { Type = "number", Min = 0, Max = 1000, Optional = true },
	MainAttackOverrideDataDuration = { Type = "number", Min = 0, Max = 600, Optional = true }
}
Schema.TowerAbilityShape = {
	Children = {
		SpawnPathEntities = Schema.SpawnPathEntitiesNode("SpawnPathEntityData")
	}
}
Schema.TowerAbilityMainAttack = {
	Damage = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	DamageType = { Type = "damageType", Optional = true },
	ReloadTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	Range = { Type = "number", Min = 0, Max = 1000, Optional = true },
	IsSplash = { Type = "boolean", Optional = true },
	SplashRadius = { Type = "number", Min = 0, Max = 1000, Optional = true }
}
Schema.WaveTop = {
	StartingCash = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	StartingLives = { Type = "integer", Min = 1, Max = 1000000000 },
	SetUpTime = { Type = "number", Min = 0, Max = 600 },
	DefaultXPPerWavePassed = { Type = "number", Min = 0, Max = 1000000, Optional = true }
}
Schema.WaveStartingCashValue = { Type = "number", Min = 0, Max = 1000000000 }
Schema.WaveCashPerDamage = {
	CashPerDamage = { Type = "number", Min = 0, Max = 1000 },
	CashPerDamageShared = { Type = "number", Min = 0, Max = 1000 }
}
Schema.WaveTowerCostMultiplier = { Type = "number", Min = 0, Max = 100 }
Schema.WaveEntry = {
	CashBonus = { Type = "number", Min = 0, Max = 1000000000 },
	CustomWaveTime = { Type = "number", Min = 0, Max = 1200, Optional = true },
	OverrideXP = { Type = "number", Min = 0, Max = 1000000, Optional = true },
	CashMultiplierOverride = { Type = "number", Min = 0, Max = 100, Optional = true }
}
Schema.Sequence = {
	StartDelay = { Type = "number", Min = 0, Max = 600 },
	Count = { Type = "integer", Min = 0, Max = 10000 },
	Interval = { Type = "number", Min = 0, Max = 600 },
	EnemyType = { Type = "enemyType" },
	Stealth = { Type = "boolean", Optional = true },
	AdditionalHealthMultiplier = { Type = "number", Min = -1000, Max = 1000, Optional = true },
	AdditionalShieldMultiplier = { Type = "number", Min = -1000, Max = 1000, Optional = true },
	AdditionalSpeedBoostMultiplier = { Type = "number", Min = -1, Max = 100, Optional = true },
	PathPercentageLowerBound = { Type = "number", Min = 0, Max = 1, Optional = true },
	PathPercentageUpperBound = { Type = "number", Min = 0, Max = 1, Optional = true }
}
Schema.PowerUp = {
	MaxUses = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	MinWave = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	Cooldown = { Type = "number", Min = 0, Max = 6000, Optional = true },
	Speed = { Type = "number", Min = 0, Max = 10000 },
	Altitude = { Type = "number", Min = 0, Max = 10000 },
	EntranceDistance = { Type = "number", Min = 0, Max = 10000 },
	ExitDistance = { Type = "number", Min = 0, Max = 10000 },
	EntranceDistanceXZ = { Type = "number", Min = 0, Max = 10000 },
	DropHeight = { Type = "number", Min = 0, Max = 10000 },
	KeepTimeAfterHit = { Type = "number", Min = 0, Max = 600 },
	EntranceSpeed = { Type = "number", Min = 0, Max = 10000 },
	PylonSpeed = { Type = "number", Min = 0, Max = 10000 },
	ExitSpeed = { Type = "number", Min = 0, Max = 10000 },
	PylonRadius = { Type = "number", Min = 0, Max = 1000 },
	PylonDuration = { Type = "number", Min = 0, Max = 6000 },
	PylonPortAngle = { Type = "number", Min = 0, Max = 360 },
	PylonAltitute = { Type = "number", Min = 0, Max = 10000 },
	BombCount = { Type = "integer", Min = 0, Max = 10000 },
	StrikeZoneLength = { Type = "number", Min = 0, Max = 10000 },
	StrikeZoneWidth = { Type = "number", Min = 0, Max = 1000 },
	DropLeadTime = { Type = "number", Min = 0, Max = 600 },
	DropTimeVariance = { Type = "number", Min = 0, Max = 600 },
	Damage = { Type = "number", Min = 0, Max = 1000000000 },
	DamageType = { Type = "damageType" },
	SplashRadius = { Type = "number", Min = 0, Max = 1000 },
	CashGained = { Type = "number", Min = 0, Max = 1000000000 },
	LivesGained = { Type = "number", Min = 0, Max = 1000000000 },
	Duration = { Type = "number", Min = 0, Max = 6000 },
	Radius = { Type = "number", Min = 0, Max = 1000 },
	BodyHeatReductionPerSecond = { Type = "number", Min = 0, Max = 1000000 },
	DamagePerSecond = { Type = "number", Min = 0, Max = 1000000000 },
	ReloadTime = { Type = "number", Min = 0, Max = 600 },
	Count = { Type = "integer", Min = 0, Max = 10000 },
	IntervalLowerBound = { Type = "number", Min = 0, Max = 600 },
	IntervalUpperBound = { Type = "number", Min = 0, Max = 600 },
	AngleVariance = { Type = "number", Min = 0, Max = 360 },
	XZVariance = { Type = "number", Min = 0, Max = 1000 },
	SpeedVariance = { Type = "number", Min = 0, Max = 1000 },
	NumPathEntitiesSpawned = { Type = "integer", Min = 0, Max = 1000 }
}
Schema.PowerUpOrder = {
	"MaxUses",
	"MinWave",
	"Cooldown",
	"Speed",
	"Altitude",
	"EntranceDistance",
	"ExitDistance",
	"EntranceDistanceXZ",
	"DropHeight",
	"KeepTimeAfterHit",
	"EntranceSpeed",
	"PylonSpeed",
	"ExitSpeed",
	"PylonRadius",
	"PylonDuration",
	"PylonPortAngle",
	"PylonAltitute",
	"BombCount",
	"StrikeZoneLength",
	"StrikeZoneWidth",
	"DropLeadTime",
	"DropTimeVariance",
	"Damage",
	"DamageType",
	"SplashRadius",
	"CashGained",
	"LivesGained",
	"Duration",
	"Radius",
	"BodyHeatReductionPerSecond",
	"DamagePerSecond",
	"ReloadTime",
	"Count",
	"IntervalLowerBound",
	"IntervalUpperBound",
	"AngleVariance",
	"XZVariance",
	"SpeedVariance",
	"NumPathEntitiesSpawned"
}
Schema.PowerUpAttack = {
	DamageType = { Type = "damageType" },
	Damage = { Type = "number", Min = 0, Max = 1000000000 },
	TowerDamage = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	PathEntityDamage = { Type = "number", Min = 0, Max = 1000000000, Optional = true },
	TowerDamagePercentage = { Type = "percentage", Min = 0, Max = 1, Optional = true },
	PathEntityDamagePercentage = { Type = "percentage", Min = 0, Max = 1, Optional = true },
	IsSplash = { Type = "boolean", Optional = true },
	SplashRadius = { Type = "number", Min = 0, Max = 1000, Optional = true },
	ReloadTime = { Type = "number", Min = 0, Max = 100000 },
	BurstSize = { Type = "integer", Min = 0, Max = 10000, Optional = true },
	BurstInterval = { Type = "number", Min = 0, Max = 600, Optional = true },
	EnabledTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	DisabledTime = { Type = "number", Min = 0, Max = 600, Optional = true },
	MinimumTargetHP = { Type = "number", Min = 0, Max = 1000000000, Optional = true }
}
Schema.PowerUpAttackOrder = {
	"DamageType",
	"Damage",
	"TowerDamage",
	"PathEntityDamage",
	"TowerDamagePercentage",
	"PathEntityDamagePercentage",
	"IsSplash",
	"SplashRadius",
	"ReloadTime",
	"BurstSize",
	"BurstInterval",
	"EnabledTime",
	"DisabledTime",
	"MinimumTargetHP"
}
Schema.AllSections = {
	Schema.Enemy,
	Schema.EnemyPVP,
	Schema.EnemyAdditionalStats,
	Schema.EnemyAbilityStatOverrides,
	Schema.TowerBuff,
	Schema.EnemyBuff,
	Schema.Ability,
	Schema.AbilityProjectileHit,
	Schema.AbilityRangedData,
	Schema.AbilityDamageData,
	Schema.AbilityDamageFalloff,
	Schema.AbilityRadiusEffect,
	Schema.AbilityTowerInstantKill,
	Schema.AbilityEnemyRangedData,
	Schema.AbilityMapEntityRanged,
	Schema.AbilityHealData,
	Schema.AbilityDamageBaseData,
	Schema.AbilityCloneData,
	Schema.AbilityTimeManipulation,
	Schema.AbilitySpawnEnemy,
	Schema.AbilityBombardmentAttack,
	Schema.TowerConfigTop,
	Schema.TowerBaseStats,
	Schema.TowerUpgradeStats,
	Schema.TowerBurnEffect,
	Schema.TowerApplyBurn,
	Schema.TowerAbilityMainAttack,
	Schema.SpawnPathEntity,
	Schema.AttackData,
	Schema.PathEntity,
	Schema.StaticEntity,
	Schema.MapEntity,
	Schema.MapEntityStatOverrides,
	Schema.MultiHealData,
	Schema.PowerUp,
	Schema.PowerUpAttack,
	Schema.WaveTop,
	Schema.WaveCashPerDamage,
	Schema.WaveEntry,
	Schema.Sequence,
	Schema.PathEntityAbilityRanged,
	Schema.PathEntityAbilityRadius,
	Schema.PathEntityAbilitySpawn,
	Schema.Economy
}

function Schema.FlatFieldMap()
	local result = {}

	for _, allSection in ipairs(Schema.AllSections) do
		for k, v in pairs(allSection) do
			local v2 = result[k]

			if v2 then
				if v2.Min ~= nil then
					if v.Min == nil then
						v2.Min = nil
					elseif v.Min < v2.Min then
						v2.Min = v.Min
					end
				end

				if v2.Max ~= nil then
					if v.Max == nil then
						v2.Max = nil
					elseif v.Max > v2.Max then
						v2.Max = v.Max
					end
				end

				if v2.Type == "integer" and v.Type ~= "integer" then
					v2.Type = v.Type
				end
			else
				result[k] = { Type = v.Type, Min = v.Min, Max = v.Max, Note = v.Note }
			end
		end
	end

	return result
end

function Schema.Coerce(data, min, callback)
	local kind = data.Type

	if kind == "boolean" then
		if typeof(min) == "boolean" then
			return true, min
		end

		return false, "expected a boolean"
	elseif kind == "string" then
		if typeof(min) == "string" then
			return true, min
		end

		return false, "expected a string"
	elseif kind == "damageType" then
		if typeof(min) == "string" and min ~= "" then
			return true, min
		end

		return false, "expected a damage type name"
	elseif kind == "pathEntityType" then
		if typeof(min) == "string" and min ~= "" then
			return true, min
		end

		return false, "expected a path entity name"
	else
		if kind == "enemyType" then
			if typeof(min) ~= "string" or min == "" then
				return false, "expected a non-empty enemy name"
			end

			if callback and not callback(min) then
				return false, `unknown enemy "{min}"`
			end
		else
			if kind ~= "number" and kind ~= "integer" and kind ~= "percentage" then
				return false, `unknown field type "{tostring(kind)}"`
			end

			if typeof(min) ~= "number" or min ~= min then
				return false, "expected a number"
			end

			if data.Min and min < data.Min then
				min = data.Min
			end

			if data.Max and data.Max < min then
				min = data.Max
			end

			if kind == "integer" then
				min = math.floor(min + 0.5)
			end
		end

		return true, min
	end
end

return Schema