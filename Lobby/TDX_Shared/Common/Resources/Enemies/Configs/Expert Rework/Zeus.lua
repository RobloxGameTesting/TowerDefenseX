local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 75000,
	Shield = 42000,
	Speed = 2.5,
	BodyHeat = 11500,
	SuperStunResistance = true,
	BodyHeatRegenerationRate = 550,
	FrozenDebounceTime = 6,
	FrozenMaximumTime = 8,
	ThawTime = 0.6,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	KillBadgeId = 3543065376287382,
	IsMiniBoss = true,
	AbilityNames = {
		Enums.EnemyAbilities.ZeusRage,
		Enums.EnemyAbilities.ZeusSwordSlash,
		Enums.EnemyAbilities.ZeusSwordShock,
		Enums.EnemyAbilities.ZeusSwordThrow,
		Enums.EnemyAbilities.ZeusSwordZap
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.4,
	ForceFaceOutroTime = 0.5,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	MinimumTimeBeforeSequenceEnds = 3,
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.35 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 1000, Shield = 2000 },
		[4] = { Health = 3000, Shield = 5000 }
	}
}