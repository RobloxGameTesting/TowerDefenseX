local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Vile Engineer",
	OverrideCharacterModelName = Enums.Enemies.Engineer,
	Health = 1000000,
	Shield = 175000,
	Speed = 1.5,
	AnimationCalibratedSpeed = 1.7,
	BodyHeat = 250000,
	BodyHeatRegenerationRate = 60000,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "EngineerBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.EngineerNightmareMinigun,
		Enums.EnemyAbilities.EngineerNightmareSniper,
		Enums.EnemyAbilities.EngineerNightmareFistSlam,
		Enums.EnemyAbilities.EngineerNightmareToxicCloud,
		Enums.EnemyAbilities.EngineerNightmareBossHeal,
		Enums.EnemyAbilities.EngineerNightmareEMP,
		Enums.EnemyAbilities.EngineerNightmareSummon
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
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.15 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 100000, Shield = 0 },
		[4] = { Health = 200000, Shield = 0 }
	}
}