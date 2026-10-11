local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 85000,
	Shield = 52500,
	Speed = 1.9,
	BodyHeat = 15000,
	BodyHeatRegenerationRate = 700,
	OverrideDisplayName = "Phoebus",
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	KillBadgeId = 3335600170793678,
	IsMiniBoss = true,
	AbilityNames = {
		Enums.EnemyAbilities.PhobeusShieldRush,
		Enums.EnemyAbilities.PhobeusShieldStance,
		Enums.EnemyAbilities.PhobeusFlamethrower,
		Enums.EnemyAbilities.PhobeusChargeShot
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DeathAbilityNames = { Enums.EnemyAbilities.PhobeusDeathExplosion },
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
	ShieldModelName = "ForceField",
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.55 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Health = 1000, Shield = 1250 },
		[3] = { Health = 5000, Shield = 3000 },
		[4] = { Health = 7000, Shield = 8250 }
	}
}