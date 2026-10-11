local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1250000,
	Shield = 450000,
	Speed = 2.6,
	BodyHeat = 85000,
	BodyHeatRegenerationRate = 1000,
	OverrideDisplayName = "X-2 Trooper",
	HasCustomCode = true,
	OverrideCustomCodeName = Enums.Enemies.X2Fighter,
	Radius = 1,
	AnimationTimeScale = 1,
	KillBadgeId = 1276034866263734,
	IsBoss = true,
	BossMusicName = "X2FighterBossMusic",
	AbilityNames = {
		{ Name = Enums.EnemyAbilities.X2TrooperRage },
		{ Name = Enums.EnemyAbilities.X2TrooperRage_Invulnerable },
		{ Name = Enums.EnemyAbilities.X2TrooperRage_Strafe1 },
		{ Name = Enums.EnemyAbilities.X2TrooperRage_Strafe2 },
		{ Name = Enums.EnemyAbilities.X2TrooperRage_Land },
		{ Name = Enums.EnemyAbilities.X2TrooperAssaultRifle },
		{ Name = Enums.EnemyAbilities.X2TrooperMinigunArc },
		{ Name = Enums.EnemyAbilities.X2TrooperEMP }
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.X2TrooperAssaultRifle] = { DamageMultiplier = 0.3 },
			[Enums.EnemyAbilities.X2TrooperRage_Strafe1] = { DamageMultiplier = 0.3 },
			[Enums.EnemyAbilities.X2TrooperRage_Strafe2] = { DamageMultiplier = 0.3 },
			[Enums.EnemyAbilities.X2TrooperRage_Land] = { DamageMultiplier = 0.2 }
		}
	},
	DeathAbilityNames = {},
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 11,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 50000, Shield = 175000 },
		[4] = { Health = 150000, Shield = 350000 }
	}
}