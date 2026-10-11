local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000000,
	Speed = 0.8,
	AnimationCalibratedSpeed = 2.875,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 9001,
	OverrideDisplayName = "Void Apex Predator",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 5.15,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "VoidApexPredatorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.VoidApexPredatorSummon,
		Enums.EnemyAbilities.VoidApexPredatorAxeSlam,
		Enums.EnemyAbilities.VoidApexPredatorFlamethrower,
		Enums.EnemyAbilities.VoidApexPredatorLaserEye,
		Enums.EnemyAbilities.VoidApexPredatorLaserShot,
		Enums.EnemyAbilities.VoidApexPredatorHandLaserShot,
		Enums.EnemyAbilities.VoidApexPredatorMissileBurst
	},
	AbilityBufferTime = 2,
	ForceFaceIntroTime = 0.65,
	ForceFaceOutroTime = 1.2,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.VoidApexPredatorSummon] = { Disabled = true },
			[Enums.EnemyAbilities.VoidApexPredatorAxeSlam] = { DamageMultiplier = 0.65 },
			[Enums.EnemyAbilities.VoidApexPredatorLaserEye] = { DamageMultiplier = 0.85 },
			[Enums.EnemyAbilities.VoidApexPredatorLaserShot] = { DamageMultiplier = 0.65 },
			[Enums.EnemyAbilities.VoidApexPredatorFlamethrower] = { DamageMultiplier = 1.25 },
			[Enums.EnemyAbilities.VoidApexPredatorMissileBurst] = { DamageMultiplier = 0.65 },
			[Enums.EnemyAbilities.VoidApexPredatorHandLaserShot] = { DamageMultiplier = 0.65 }
		}
	},
	DeathAbilityNames = { Enums.EnemyAbilities.VoidApexPredatorDeathExplosion },
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
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.99 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}