local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1750000,
	Shield = 1000000,
	Speed = 4,
	AnimationCalibratedSpeed = 2.3,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 50000,
	OverrideDisplayName = "Apex Predator",
	OverrideCharacterModelName = "Apex Predator",
	HasCustomCode = true,
	OverrideCustomCodeName = "Apex Predator",
	Radius = 1,
	HoverHeight = 4.12,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "ApexPredatorBossMusic",
	DeathSpawnData = {
		{ EnemyType = Enums.Enemies.AlphaPredator, Count = 1, Delay = 6.55, ExactPosition = true }
	},
	AbilityNames = {
		Enums.EnemyAbilities.PartyApexPredatorSummon,
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
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	KillBadgeId = 1274056175892888,
	PreloadEnemies = { Enums.Enemies.AlphaPredator }
}