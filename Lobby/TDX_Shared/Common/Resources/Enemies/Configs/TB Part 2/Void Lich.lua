local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100000,
	Speed = 2,
	BodyHeat = 25000,
	BodyHeatRegenerationRate = 400,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.2,
	IsMiniBoss = true,
	BossMusicName = "VoidLichBossMusic",
	KillBadgeId = 3759238406386320,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 0,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 0,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	AbilityNames = {
		Enums.EnemyAbilities.VoidLichSwordSlash,
		Enums.EnemyAbilities.VoidLichSwordStab,
		Enums.EnemyAbilities.VoidLichStaffBuff,
		Enums.EnemyAbilities.VoidLichStaffSummon
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.8,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.TBPart2Nightmare] = {
			OverrideBossMusicName = "VoidLichNightmareBossMusic"
		},
		[Enums.Difficulties.TBPart2Voidmare] = {
			OverrideBossMusicName = "VoidLichNightmareBossMusic"
		}
	},
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Casual] = {
			[Enums.EnemyAbilities.VoidLichSwordSlash] = { DamageMultiplier = 0.2 },
			[Enums.EnemyAbilities.VoidLichSwordStab] = { DamageMultiplier = 0.2 },
			[Enums.EnemyAbilities.VoidLichStaffSummon] = { Cooldown = 70 }
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.1 }
	}
}