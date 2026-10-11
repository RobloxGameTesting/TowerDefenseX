local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 750000,
	Speed = 1.8,
	AnimationCalibratedSpeed = 2.3,
	BodyHeat = 80000,
	BodyHeatRegenerationRate = 1500,
	FrozenDebounceTime = 20,
	FrozenMaximumTime = 12,
	ThawTime = 1.2,
	OverrideDisplayName = "Apex Predator",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 4.12,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "ApexPredatorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.ApexPredatorSummon,
		Enums.EnemyAbilities.ApexPredatorAxeSlam,
		Enums.EnemyAbilities.ApexPredatorFlamethrower,
		Enums.EnemyAbilities.ApexPredatorLaserEye,
		Enums.EnemyAbilities.ApexPredatorLaserShot,
		Enums.EnemyAbilities.ApexPredatorHandLaserShot,
		Enums.EnemyAbilities.ApexPredatorMissileBurst
	},
	AbilityBufferTime = 2,
	ForceFaceIntroTime = 0.65,
	ForceFaceOutroTime = 1.2,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.ApexPredatorSummon] = { Disabled = true },
			[Enums.EnemyAbilities.ApexPredatorAxeSlam] = { DamageMultiplier = 0.65 },
			[Enums.EnemyAbilities.ApexPredatorLaserEye] = { DamageMultiplier = 0.45 },
			[Enums.EnemyAbilities.ApexPredatorLaserShot] = { DamageMultiplier = 0.55 },
			[Enums.EnemyAbilities.ApexPredatorFlamethrower] = { DamageMultiplier = 1.15 },
			[Enums.EnemyAbilities.ApexPredatorMissileBurst] = { DamageMultiplier = 0.55 },
			[Enums.EnemyAbilities.ApexPredatorHandLaserShot] = { DamageMultiplier = 0.55 }
		}
	},
	DeathAbilityNames = { Enums.EnemyAbilities.ApexPredatorDeathExplosion },
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	MinimumTimeBeforeSequenceEnds = 8,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	KillBadgeId = 1274056175892888
}