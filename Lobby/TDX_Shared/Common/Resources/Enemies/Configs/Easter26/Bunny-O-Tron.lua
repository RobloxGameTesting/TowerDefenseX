local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local BunnyOTron = {
	Health = 500000,
	Shield = 50000,
	Speed = 1.8,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	AnimationTimeScale = 1,
	SpawnPathPercentage = 0.15,
	SpawnPathPercentageVariance = 0,
	SpawnAnimationTime = 11.567,
	SpawnInvulnerabilityTime = 3.9,
	SpawnLandingData = {
		StartHeight = 150,
		Time = 0.9,
		LandEffectNames = { "SpawnLanding" }
	},
	IsBoss = true,
	BossMusicName = "BunnyOTronBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.BunnyOTronJumpTower,
		Enums.EnemyAbilities.BunnyOTronJumpPathEntity,
		Enums.EnemyAbilities.BunnyOTronBallerina,
		Enums.EnemyAbilities.BunnyOTronBallerina_Landing,
		Enums.EnemyAbilities.BunnyOTronLaserHands,
		Enums.EnemyAbilities.BunnyOTronMissileRain
	},
	AbilityBufferTime = 2,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part1Easy] = {
		[Enums.EnemyAbilities.BunnyOTronJumpTower] = {
			StartingCooldown = nil,
			Cooldown = 25,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyOTronJumpPathEntity] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyOTronBallerina] = {
			StartingCooldown = nil,
			Cooldown = 135,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.2
		},
		[Enums.EnemyAbilities.BunnyOTronBallerina_Landing] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.2
		},
		[Enums.EnemyAbilities.BunnyOTronLaserHands] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.3
		},
		[Enums.EnemyAbilities.BunnyOTronMissileRain] = {
			StartingCooldown = nil,
			Cooldown = 60,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 0.2
		}
	}
}
local Easter26Part1Nightmare = Enums.Difficulties.Easter26Part1Nightmare
difficultyToAbilityStatOverridesMap[Easter26Part1Nightmare] = {
	[Enums.EnemyAbilities.BunnyOTronJumpTower] = {
		StartingCooldown = nil,
		Cooldown = 25,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.BunnyOTronJumpPathEntity] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.BunnyOTronBallerina] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyOTronBallerina_Landing] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1.3
	},
	[Enums.EnemyAbilities.BunnyOTronLaserHands] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	},
	[Enums.EnemyAbilities.BunnyOTronMissileRain] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1.2
	}
}
local Easter26Part2Nightmare = Enums.Difficulties.Easter26Part2Nightmare
difficultyToAbilityStatOverridesMap[Easter26Part2Nightmare] = {
	[Enums.EnemyAbilities.BunnyOTronJumpTower] = {
		StartingCooldown = nil,
		Cooldown = 25,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 15
	},
	[Enums.EnemyAbilities.BunnyOTronJumpPathEntity] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 5
	},
	[Enums.EnemyAbilities.BunnyOTronBallerina] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.BunnyOTronBallerina_Landing] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1.3
	},
	[Enums.EnemyAbilities.BunnyOTronLaserHands] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 6
	},
	[Enums.EnemyAbilities.BunnyOTronMissileRain] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 15
	}
}
BunnyOTron.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
BunnyOTron.FootstepEffectInstanceNames = "RootPart>FootstepSFX"
BunnyOTron.SetUpFootstepKeyframeReachedEventForAllAnimations = true
BunnyOTron.NoPathOffset = true
BunnyOTron.RotationOffset = CFrame.Angles(0, 0, 0)
BunnyOTron.MinimumTimeBeforeSequenceEnds = 9
BunnyOTron.FakeEnemy = false
BunnyOTron.FadeOutOnDeath = true
BunnyOTron.FadeOutDelay = 2
BunnyOTron.FadeOutCustomTime = 3
BunnyOTron.FadeOutRemoveDelay = 12
BunnyOTron.DeathEffectsData = {
	{ InstancePath = "RootPart>DeathVFX", Delay = 4.55 }
}
BunnyOTron.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.75 },
	{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 },
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
	{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 }
}
BunnyOTron.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.Easter26Part1Easy] = { Health = 400000 },
	[Enums.Difficulties.Easter26Part1Nightmare] = { Health = 700000 }
}
BunnyOTron.PlayerCountToAdditionalStatsMap = {
	[2] = { Health = 25000, Shield = 10000 },
	[3] = { Health = 50000, Shield = 20000 },
	[4] = { Health = 100000, Shield = 25000 }
}
return BunnyOTron