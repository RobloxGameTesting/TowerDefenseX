local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	InstantLossIfReachEnd = true,
	Health = 25000000,
	Shield = 100000,
	Speed = 1.4,
	BodyHeat = 9999999999999,
	BodyHeatRegenerationRate = 9000000,
	OverrideDisplayName = "Emperor",
	OverrideCharacterModelName = "Emperor",
	HasCustomCode = true,
	OverrideCustomCodeName = "Emperor",
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
		MaximumUses = 2
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
		{ Name = Enums.EnemyAbilities.EmperorUltraDroneSummon },
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
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.UltraNightmare] = {
			[Enums.EnemyAbilities.EmperorSpawnScream] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorSpawnScream_StaffSlam] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorTimeStop] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorTimeStop_LaserBlast] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorTimeStop_Dash] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorTimeStop_Invulnerable] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorShield] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorShield_StaffSlam] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorDroneStrike] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorDroneStrike_Invulnerable] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorDash] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorHealAndZap] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorHealAndZap_Heal] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorStaffConvert] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			},
			[Enums.EnemyAbilities.EmperorSlap] = {
				StartingCooldown = nil,
				Cooldown = nil,
				DamageMultiplier = 1
			}
		}
	},
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
	DeathApplyGameResetData = { Delay = 34.65, ClearAllEntities = true },
	DeathExplodePartsScale = 3,
	DeathExplodePartsDelay = 34.5,
	DeathEffectsData = {
		{ InstancePath = "Death>Explode" }
	},
	DamageReductionTable = {},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 1000000, Shield = 200000 },
		[4] = { Health = 2500000, Shield = 450000 }
	}
}