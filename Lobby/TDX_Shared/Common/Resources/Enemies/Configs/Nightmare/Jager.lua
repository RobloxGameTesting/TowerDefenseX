local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 275000,
	Shield = 175000,
	Speed = 3,
	BodyHeat = 37000,
	BodyHeatRegenerationRate = 900,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	SpawnPathPercentage = 0.25,
	SpawnPathPercentageVariance = 0.125,
	SpawnAnimationTime = 2.917,
	SpawnInvulnerabilityTime = 0.25,
	IsMiniBoss = true,
	AbilityNames = {
		{ Name = Enums.EnemyAbilities.JagerLaserSweep },
		{ Name = Enums.EnemyAbilities.JagerLaserSingleTarget },
		{ Name = Enums.EnemyAbilities.JagerJump },
		{ Name = Enums.EnemyAbilities.JagerJump_ShootGround }
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 3,
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Health = 1000, Shield = 1250 },
		[3] = { Health = 5000, Shield = 3000 },
		[4] = { Health = 7000, Shield = 8250 }
	}
}