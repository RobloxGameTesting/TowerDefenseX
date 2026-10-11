local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Nightmare Heretic",
	OverrideCharacterModelName = Enums.Enemies.Heretic,
	Health = 65000,
	Speed = 0.8,
	AnimationCalibratedSpeed = 1.18,
	BodyHeat = 7000,
	BodyHeatRegenerationRate = 1500,
	Radius = 1,
	HoverHeight = 0.33,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "HereticBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.HereticNightmareSummon,
		Enums.EnemyAbilities.HereticNightmareFireball,
		Enums.EnemyAbilities.HereticNightmareSpeedboost,
		Enums.EnemyAbilities.HereticNightmareStrongestHeal,
		Enums.EnemyAbilities.HereticNightmareBossDamageBuff,
		Enums.EnemyAbilities.HereticNightmareLightning
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
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 1 }
	}
}