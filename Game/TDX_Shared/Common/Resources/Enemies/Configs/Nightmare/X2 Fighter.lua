local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 500000,
	Shield = 175000,
	Speed = 2,
	BodyHeat = 75000,
	BodyHeatRegenerationRate = 950,
	OverrideDisplayName = "X-2 Fighter",
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "X2FighterBossMusic",
	AbilityNames = {
		{ Name = Enums.EnemyAbilities.X2FighterRage },
		{ Name = Enums.EnemyAbilities.X2FighterRage_Invulnerable },
		{ Name = Enums.EnemyAbilities.X2FighterRage_Strafe1 },
		{ Name = Enums.EnemyAbilities.X2FighterRage_Strafe2 },
		{ Name = Enums.EnemyAbilities.X2FighterRage_Land },
		{ Name = Enums.EnemyAbilities.X2FighterAssaultRifle },
		{ Name = Enums.EnemyAbilities.X2FighterMinigunArc },
		{ Name = Enums.EnemyAbilities.X2FighterEMP }
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7,
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
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 50000, Shield = 175000 },
		[4] = { Health = 150000, Shield = 350000 }
	}
}