local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local GingerDread = {
	OverrideDisplayName = "Ginger D.R.E.A.D.",
	Health = 300000,
	Speed = 1.8,
	AnimationCalibratedSpeed = 1.8,
	BodyHeat = 70000,
	BodyHeatRegenerationRate = 1250,
	FrozenDebounceTime = 8,
	FrozenMaximumTime = 8,
	ThawTime = 0.6,
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 5.231,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "GingerDreadBossMusic",
	AbilityNames = {
		{
			Name = Enums.EnemyAbilities.GingerDreadRage,
			DisableDifficulties = {
				Enums.Difficulties.Christmas24Part1Nightmare,
				Enums.Difficulties.Christmas24Part2Nightmare
			}
		},
		{
			Name = Enums.EnemyAbilities.GingerDreadRageNightmare,
			EnableDifficulties = {
				Enums.Difficulties.Christmas24Part1Nightmare,
				Enums.Difficulties.Christmas24Part2Nightmare
			}
		},
		{
			Name = Enums.EnemyAbilities.GingerDreadSmash,
			DisableDifficulties = {
				Enums.Difficulties.Christmas24Part1Nightmare,
				Enums.Difficulties.Christmas24Part2Nightmare
			}
		},
		{
			Name = Enums.EnemyAbilities.GingerDreadSmashNightmare,
			EnableDifficulties = {
				Enums.Difficulties.Christmas24Part1Nightmare,
				Enums.Difficulties.Christmas24Part2Nightmare
			}
		},
		{ Name = Enums.EnemyAbilities.GingerDreadLaserEye },
		{ Name = Enums.EnemyAbilities.GingerDreadLaserSweep },
		{ Name = Enums.EnemyAbilities.GingerDreadCookieShot },
		{ Name = Enums.EnemyAbilities.GingerDreadCookieBurstGround },
		{ Name = Enums.EnemyAbilities.GingerDreadCookieBurstAir },
		{
			Name = Enums.EnemyAbilities.GingerDreadSummon,
			DisableDifficulties = {
				Enums.Difficulties.Christmas24Part1Nightmare,
				Enums.Difficulties.Christmas24Part2,
				Enums.Difficulties.Christmas24Part2Nightmare,
				Enums.Difficulties.Test
			}
		},
		{
			Name = Enums.EnemyAbilities.GingerDreadSummonNightmare,
			EnableDifficulties = { Enums.Difficulties.Christmas24Part1Nightmare }
		},
		{
			Name = Enums.EnemyAbilities.GingerDreadLaserEyeForBase,
			EnableDifficulties = {
				Enums.Difficulties.Christmas24Part2,
				Enums.Difficulties.Christmas24Part2Nightmare,
				Enums.Difficulties.Test
			}
		},
		{
			Name = Enums.EnemyAbilities.GingerDreadCookieShotForBase,
			EnableDifficulties = {
				Enums.Difficulties.Christmas24Part2,
				Enums.Difficulties.Christmas24Part2Nightmare,
				Enums.Difficulties.Test
			}
		}
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DeathAbilityNames = { Enums.EnemyAbilities.GingerDreadDeathExplosion }
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Christmas24Part1Nightmare] = {
		[Enums.EnemyAbilities.GingerDreadCookieShot] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 4
		},
		[Enums.EnemyAbilities.GingerDreadCookieBurstGround] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 2
		},
		[Enums.EnemyAbilities.GingerDreadCookieBurstAir] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 5
		},
		[Enums.EnemyAbilities.GingerDreadLaserSweep] = {
			StartingCooldown = 5,
			Cooldown = 20,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 2
		}
	}
}
local Christmas24Part2Nightmare = Enums.Difficulties.Christmas24Part2Nightmare
difficultyToAbilityStatOverridesMap[Christmas24Part2Nightmare] = {
	[Enums.EnemyAbilities.GingerDreadCookieShot] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.GingerDreadCookieBurstGround] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.GingerDreadCookieBurstAir] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	},
	[Enums.EnemyAbilities.GingerDreadLaserSweep] = {
		StartingCooldown = 5,
		Cooldown = 20,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	}
}
local Christmas24Part2 = Enums.Difficulties.Christmas24Part2
difficultyToAbilityStatOverridesMap[Christmas24Part2] = {
	[Enums.EnemyAbilities.GingerDreadCookieShot] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 3,
		CooldownVariance = 3,
		DamageMultiplier = nil
	},
	[Enums.EnemyAbilities.GingerDreadCookieBurstGround] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 3,
		CooldownVariance = 3,
		DamageMultiplier = nil
	},
	[Enums.EnemyAbilities.GingerDreadCookieBurstAir] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 3,
		CooldownVariance = 3,
		DamageMultiplier = nil
	},
	[Enums.EnemyAbilities.GingerDreadLaserSweep] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 3,
		CooldownVariance = 3,
		DamageMultiplier = nil
	}
}
local UltraNightmare = Enums.Difficulties.UltraNightmare
difficultyToAbilityStatOverridesMap[UltraNightmare] = {
	[Enums.EnemyAbilities.GingerDreadCookieShot] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 4.5
	},
	[Enums.EnemyAbilities.GingerDreadCookieBurstGround] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2.5
	},
	[Enums.EnemyAbilities.GingerDreadCookieBurstAir] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5.5
	},
	[Enums.EnemyAbilities.GingerDreadLaserSweep] = {
		StartingCooldown = 5,
		Cooldown = 20,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2.5
	}
}
local Test = Enums.Difficulties.Test
difficultyToAbilityStatOverridesMap[Test] = {
	[Enums.EnemyAbilities.GingerDreadCookieShot] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 3,
		CooldownVariance = 3,
		DamageMultiplier = nil
	},
	[Enums.EnemyAbilities.GingerDreadCookieBurstGround] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 3,
		CooldownVariance = 3,
		DamageMultiplier = nil
	},
	[Enums.EnemyAbilities.GingerDreadCookieBurstAir] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 3,
		CooldownVariance = 3,
		DamageMultiplier = nil
	},
	[Enums.EnemyAbilities.GingerDreadLaserSweep] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = 3,
		CooldownVariance = 3,
		DamageMultiplier = nil
	}
}
GingerDread.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
GingerDread.FootstepEffectInstanceNames = "Root>FootstepSFX"
GingerDread.SetUpFootstepKeyframeReachedEventForAllAnimations = true
GingerDread.NoPathOffset = false
GingerDread.RotationOffset = CFrame.Angles(0, 3.141592653589793, 0)
GingerDread.MinimumTimeBeforeSequenceEnds = 3
GingerDread.DeathEffect = Enums.DeathEffects.ZombieBlood
GingerDread.FadeOutOnDeath = true
GingerDread.FadeOutDelay = 1.5
GingerDread.FadeOutCustomTime = 0.5
GingerDread.FadeOutRemoveDelay = 2
GingerDread.FakeEnemy = false
GingerDread.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.75 },
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 },
	{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 }
}
GingerDread.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.Christmas24Part1Nightmare] = {
		OverrideDisplayName = "Burnt Ginger D.R.E.A.D.",
		Health = 700000,
		Shield = 100000,
		BodyHeat = 3000000,
		BodyHeatRegenerationRate = 100000
	},
	[Enums.Difficulties.Christmas24Part2Nightmare] = {
		OverrideDisplayName = "Burnt Ginger D.R.E.A.D.",
		Health = 700000,
		Shield = 100000,
		BodyHeat = 3000000,
		BodyHeatRegenerationRate = 100000
	}
}
return GingerDread