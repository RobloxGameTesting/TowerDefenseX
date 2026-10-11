local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 275000,
	Speed = 1.5,
	AnimationCalibratedSpeed = 1.7,
	BodyHeat = 80000,
	BodyHeatRegenerationRate = 40000,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "EngineerBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.EngineerMinigun,
		Enums.EnemyAbilities.EngineerSniper,
		Enums.EnemyAbilities.EngineerFistSlam,
		Enums.EnemyAbilities.EngineerToxicCloud,
		Enums.EnemyAbilities.EngineerBossHeal,
		Enums.EnemyAbilities.EngineerEMP,
		Enums.EnemyAbilities.EngineerSummon
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 5,
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 25000, Shield = 0 },
		[4] = { Health = 50000, Shield = 0 }
	}
}