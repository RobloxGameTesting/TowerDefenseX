local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	HasCustomCode = true,
	Health = 50000,
	Speed = 1.5,
	BodyHeat = 2500,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	IsBoss = true,
	BossMusicName = "EradBBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.EradBRage,
		Enums.EnemyAbilities.EradBRockets,
		Enums.EnemyAbilities.EradBFlamethrower
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.EradBRage] = { HealAmountMultiplier = 0.2 },
			[Enums.EnemyAbilities.EradBRockets] = { DamageMultiplier = 2 },
			[Enums.EnemyAbilities.EradBFlamethrower] = { DamageMultiplier = 3 },
			[Enums.EnemyAbilities.EradBDeathExplosion] = { DamageMultiplier = 0.2 }
		}
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.PVP_1V1] = { BodyHeatRegenerationRate = 250 }
	},
	DeathAbilityNames = { Enums.EnemyAbilities.EradBDeathExplosion },
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	MinimumTimeBeforeSequenceEnds = 3,
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {}
}