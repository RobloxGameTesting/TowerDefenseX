local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 1000000,
	Speed = 3.4,
	BodyHeat = 106666,
	BodyHeatRegenerationRate = 966,
	HoverHeight = 15,
	Radius = 1,
	KillBadgeId = 2454325260966404,
	UnstasisNoHoverTooltip = true,
	UnstasisTime = 3.383,
	UnstasisMovementStartDelay = 2.5,
	UnstasisAnimationName = "Fall",
	IsBoss = true,
	BossMusicName = "ForgottenKnightBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.ForgottenKnightFlamethrower,
		Enums.EnemyAbilities.ForgottenKnightCurseBase,
		Enums.EnemyAbilities.ForgottenKnightVineAllTowers,
		Enums.EnemyAbilities.ForgottenKnightSummon
	},
	AbilityBufferTime = 3,
	AbilityMaxUsesPathPercentageIncrements = {
		[Enums.EnemyAbilities.ForgottenKnightFlamethrower] = 0.79
	},
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantBatDeath,
	MinimumTimeBeforeSequenceEnds = 6,
	HasCustomCode = true,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 8,
	FootstepEffectInstanceNames = { "RootPart>FootstepSFX" },
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.65 }
	}
}