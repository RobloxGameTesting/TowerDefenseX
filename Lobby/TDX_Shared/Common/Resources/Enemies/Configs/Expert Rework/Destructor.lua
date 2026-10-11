local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 675000,
	Shield = 250000,
	Speed = 1.8,
	BodyHeat = 28000,
	BodyHeatRegenerationRate = 500,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	KillBadgeId = 3498426379502089,
	IsBoss = true,
	BossMusicName = "DestructorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.DestructorRage,
		Enums.EnemyAbilities.DestructorRage_FistSlam,
		Enums.EnemyAbilities.DestructorJetpack,
		Enums.EnemyAbilities.DestructorJetpack_Land,
		Enums.EnemyAbilities.DestructorJetpackDamaged,
		Enums.EnemyAbilities.DestructorJetpackDamaged_Land,
		Enums.EnemyAbilities.DestructorAreaShock,
		Enums.EnemyAbilities.DestructorFocusedShock,
		Enums.EnemyAbilities.DestructorEMP,
		Enums.EnemyAbilities.DestructorEMP_Parallel,
		Enums.EnemyAbilities.DestructorRailgun,
		Enums.EnemyAbilities.DestructorRailgunAntiAir
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.6,
	FootstepEffectInstanceNames = "HumanoirdRootPart>FootstepSFX",
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
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.15 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Health = 25000, Shield = 10000 },
		[3] = { Health = 50000, Shield = 37500 },
		[4] = { Health = 75000, Shield = 125000 }
	}
}