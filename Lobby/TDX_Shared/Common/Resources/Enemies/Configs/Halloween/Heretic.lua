local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 27357,
	Speed = 1.1,
	AnimationCalibratedSpeed = 1.18,
	BodyHeat = 6000,
	BodyHeatRegenerationRate = 500,
	FrozenMaximumTime = 8,
	Radius = 1,
	HoverHeight = 0.33,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "HereticBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.HereticSummon,
		Enums.EnemyAbilities.HereticFireball,
		Enums.EnemyAbilities.HereticSpeedboost,
		Enums.EnemyAbilities.HereticStrongestHeal,
		Enums.EnemyAbilities.HereticBossDamageBuff
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
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}