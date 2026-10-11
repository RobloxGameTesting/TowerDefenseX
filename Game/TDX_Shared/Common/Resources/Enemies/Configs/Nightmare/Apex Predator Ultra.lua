local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 875000,
	Shield = 275000,
	Speed = 1.8,
	AnimationCalibratedSpeed = 2.3,
	BodyHeat = 500000,
	BodyHeatRegenerationRate = 900,
	OverrideDisplayName = "Apex Predator",
	OverrideCharacterModelName = "Apex Predator",
	HasCustomCode = true,
	OverrideCustomCodeName = "Apex Predator",
	Radius = 1,
	HoverHeight = 4.12,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "ApexPredatorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.ApexPredatorUltraSummon,
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
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.UltraNightmare] = {
			[Enums.EnemyAbilities.ApexPredatorAxeSlam] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.ApexPredatorFlamethrower] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.ApexPredatorLaserEye] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.ApexPredatorLaserShot] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.ApexPredatorHandLaserShot] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.ApexPredatorMissileBurst] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			}
		}
	},
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
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 }
	},
	KillBadgeId = 1274056175892888
}