local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 125000,
	Shield = 75000,
	Speed = 2.2,
	BodyHeat = 8000,
	SuperStunResistance = true,
	BodyHeatRegenerationRate = 375,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	IsMiniBoss = true,
	AbilityNames = {
		Enums.EnemyAbilities.KingSummon,
		Enums.EnemyAbilities.KingSwordSlash,
		Enums.EnemyAbilities.KingSwordStun
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.4,
	ForceFaceOutroTime = 0.5,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.KingSwordSlash] = { DamageMultiplier = 5 },
			[Enums.EnemyAbilities.KingSwordStun] = { DamageMultiplier = 6 }
		}
	},
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
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 1000, Shield = 2000 },
		[4] = { Health = 3000, Shield = 5000 }
	}
}