local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Collision Stage 2",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.VehicleCollisionHit,
		TargetTorsoInsteadOfGround = true
	},
	IgnoreOnClient = true,
	NoStopToAttack = true,
	CanTargetAir = false,
	IgnoreGround = false,
	CanTargetBase = false,
	CanTargetBaseUsingEndNodes = false,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	DisabledUntilAbilityWithNameUsed = Enums.EnemyAbilities.WretchTransition,
	OverrideStealthDetection = true,
	TargetMinimumValue = 0,
	ConsiderTargetsWithNoAttack = true,
	IsProjectile = false,
	IsSplash = false,
	Damage = 1000000,
	ReloadTime = 0.01,
	Range = 1.5,
	IsBurst = false
}
local TheWretched = {
	Health = 5000000,
	Shield = 0,
	Speed = 2.5,
	AnimationCalibratedSpeed = 2.5,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 60000,
	OverrideDisplayName = "The Wretched",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 5.89,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	StunResistance = true,
	SuperStunResistance = true,
	IsBoss = true,
	BossMusicName = "TheWretchedBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.WretchTransition,
		Enums.EnemyAbilities.WretchStage1Jump,
		Enums.EnemyAbilities.WretchStage1JumpDamage,
		Enums.EnemyAbilities.WretchStage1Summon,
		Enums.EnemyAbilities.WretchStage1Summon_Nightmare,
		Enums.EnemyAbilities.WretchStage1AirRockets,
		Enums.EnemyAbilities.WretchStage1Railgun,
		Enums.EnemyAbilities.WretchStage1PalmGuns,
		Enums.EnemyAbilities.WretchStage1PalmGunsForBase,
		Enums.EnemyAbilities.WretchStage2Burrow,
		Enums.EnemyAbilities.WretchStage2UnburrowDamage,
		Enums.EnemyAbilities.WretchStage2Summon,
		Enums.EnemyAbilities.WretchStage2Summon_Nightmare,
		Enums.EnemyAbilities.WretchStage2PalmGuns,
		Enums.EnemyAbilities.WretchStage2PalmGunsForBase
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 1,
	ForceFaceOutroTime = 1.2,
	DeathAbilityNames = {}
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.HalloweenPart4] = {
		[Enums.EnemyAbilities.WretchStage1Summon_Nightmare] = { Disabled = true },
		[Enums.EnemyAbilities.WretchStage2Summon_Nightmare] = { Disabled = true }
	}
}
local HalloweenNightmarePart4 = Enums.Difficulties.HalloweenNightmarePart4
difficultyToAbilityStatOverridesMap[HalloweenNightmarePart4] = {
	[Enums.EnemyAbilities.WretchStage1Summon] = { Disabled = true },
	[Enums.EnemyAbilities.WretchStage2Summon] = { Disabled = true },
	[Enums.EnemyAbilities.WretchStage1JumpDamage] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.WretchStage1AirRockets] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.WretchStage1Railgun] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.WretchStage1PalmGuns] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.WretchStage1PalmGunsForBase] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1.5
	},
	[Enums.EnemyAbilities.WretchStage2UnburrowDamage] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 2
	},
	[Enums.EnemyAbilities.WretchStage2PalmGuns] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1.5
	},
	[Enums.EnemyAbilities.WretchStage2PalmGunsForBase] = {
		StartingCooldown = nil,
		Cooldown = nil,
		StartingCooldownVariance = nil,
		CooldownVariance = nil,
		DamageMultiplier = 1.5
	}
}
TheWretched.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
TheWretched.FootstepEffectInstanceNames = "RootPart>FootstepSFX"
TheWretched.SetUpFootstepKeyframeReachedEventForAllAnimations = true
TheWretched.AttackData = { v }
TheWretched.HasAttack = true
TheWretched.StopToAttack = false
TheWretched.StealthDetection = false
TheWretched.RangeVariance = false
TheWretched.NoPathOffset = true
TheWretched.RotationOffset = CFrame.Angles(0, 0, 0)
TheWretched.MinimumTimeBeforeSequenceEnds = 5
TheWretched.FakeEnemy = false
TheWretched.FadeOutOnDeath = true
TheWretched.FadeOutDelay = 5
TheWretched.FadeOutCustomTime = 1
TheWretched.FadeOutRemoveDelay = 1
TheWretched.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.5 },
	{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
	{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
}
TheWretched.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.HalloweenNightmarePart4] = {
		OverrideDisplayName = "Nightmare Wretched",
		Health = 7000000,
		Shield = 250000
	}
}
TheWretched.PlayerCountToAdditionalStatsMap = {
	[3] = { Health = 500000, Shield = 0 },
	[4] = { Health = 1000000, Shield = 0 }
}
return TheWretched