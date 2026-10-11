local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local BunnyTank900 = {
	Health = 300000,
	Shield = 50000,
	Speed = 2.1,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 1200,
	FrozenDebounceTime = 12,
	FrozenMaximumTime = 8,
	ThawTime = 0.6,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 1.2,
	HasCustomCode = true,
	IsMiniBoss = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FakeEnemy = false,
	AbilityNames = {
		Enums.EnemyAbilities.BunnyTank900PassiveRockets,
		Enums.EnemyAbilities.BunnyTank900ArmRockets,
		Enums.EnemyAbilities.BunnyTank900LaserBeam,
		Enums.EnemyAbilities.BunnyTank900Transition,
		Enums.EnemyAbilities.BunnyTank900LaserBall,
		Enums.EnemyAbilities.BunnyTank900LaserSpin,
		Enums.EnemyAbilities.BunnyTank900LaserSpinRockets
	},
	AbilityBufferTime = 2,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7,
	DifficultyToAbilityStatOverridesMap = 0,
	DamageReductionTable = 0,
	DifficultyToStatOverrideMap = 0,
	PlayerCountToAdditionalStatsMap = 0,
	SecondLifeData = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Easter26Part1Easy] = {
		[Enums.EnemyAbilities.BunnyTank900PassiveRockets] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyTank900ArmRockets] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyTank900LaserBeam] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyTank900LaserBall] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyTank900LaserSpin] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.BunnyTank900LaserSpinRockets] = {
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
	[Enums.EnemyAbilities.BunnyTank900PassiveRockets] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyTank900ArmRockets] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyTank900LaserBeam] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyTank900LaserBall] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyTank900LaserSpin] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.BunnyTank900LaserSpinRockets] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1
	}
}
BunnyTank900.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
BunnyTank900.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.4 },
	{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.35 },
	{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 }
}
BunnyTank900.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.Easter26Part1Easy] = { Health = 250000 },
	[Enums.Difficulties.Easter26Part1Nightmare] = { Health = nil }
}
BunnyTank900.PlayerCountToAdditionalStatsMap = {
	[3] = { Health = 50000, Shield = 50000 },
	[4] = { Health = 75000, Shield = 75000 }
}
BunnyTank900.SecondLifeData = {
	NewDisplayName = "Bunny Hover Tank 900",
	NewSpeed = 3,
	NewHealth = 200000,
	AbilityName = Enums.EnemyAbilities.BunnyTank900Transition
}
return BunnyTank900