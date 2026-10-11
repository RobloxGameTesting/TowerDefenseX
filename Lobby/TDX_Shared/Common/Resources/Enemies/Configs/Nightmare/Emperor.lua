local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	InstantLossIfReachEnd = true,
	Health = 20000000,
	Shield = 100000,
	Speed = 1.4,
	KnockbackResistance = true,
	BodyHeat = 9999999999999,
	BodyHeatRegenerationRate = 9000000,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.3,
	AnimationDefaultStopFadeTime = 0.3,
	IgnoreAdditionalSpeedMultiplier = true,
	KillAllOtherEnemiesOnDeath = true,
	KillAllOtherEnemiesOnDeathIgnoreOwnSequence = true,
	KillBadgeId = 3232233101774450,
	EnemyTeleportOnPathPercentageData = {
		TriggerPathPercentage = 0.97,
		GoalPathPercentage = 0.07,
		MaximumUses = 3
	},
	PreTeleportVFXName = Enums.VisualEffects.EmperorPreTeleportVFX,
	PostTeleportEffectParentInstanceNames = { "PostTeleport" },
	IsBoss = true,
	BossMusicName = "EmperorBossMusic",
	AbilityNames = {
		{ Name = Enums.EnemyAbilities.EmperorSpawnScream },
		{ Name = Enums.EnemyAbilities.EmperorSpawnScream_StaffSlam },
		{ Name = Enums.EnemyAbilities.EmperorTimeStop },
		{ Name = Enums.EnemyAbilities.EmperorTimeStop_LaserBlast },
		{ Name = Enums.EnemyAbilities.EmperorTimeStop_Dash },
		{ Name = Enums.EnemyAbilities.EmperorTimeStop_Invulnerable },
		{ Name = Enums.EnemyAbilities.EmperorShield },
		{ Name = Enums.EnemyAbilities.EmperorShield_StaffSlam },
		{ Name = Enums.EnemyAbilities.EmperorDroneSummon },
		{ Name = Enums.EnemyAbilities.EmperorDroneStrike },
		{ Name = Enums.EnemyAbilities.EmperorDroneStrike_Invulnerable },
		{ Name = Enums.EnemyAbilities.EmperorDash },
		{ Name = Enums.EnemyAbilities.EmperorHealAndZap },
		{ Name = Enums.EnemyAbilities.EmperorHealAndZap_Heal },
		{ Name = Enums.EnemyAbilities.EmperorStaffConvert },
		{ Name = Enums.EnemyAbilities.EmperorSlap }
	},
	AbilityBufferTime = 3.2,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7,
	DeathAbilityNames = {},
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 39,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 15,
	DeathApplyGameResetData = {
		Delay = 34.65,
		SetCash = 9000000,
		SetCashSplitBetweenPlayers = true,
		SetLives = 666666,
		ClearAllEntities = true,
		IgnoreIfNotSecretWaveTriggered = true,
		ClearAllEntitiesIgnoreSecretWaveTriggered = true
	},
	DeathExplodePartsScale = 3,
	DeathExplodePartsDelay = 34.5,
	DeathEffectsData = {
		{ InstancePath = "Death>Explode" }
	},
	DamageReductionTable = {},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 1000000, Shield = 175000 },
		[4] = { Health = 2500000, Shield = 350000 }
	}
}