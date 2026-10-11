local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	HasCustomCode = true,
	Health = 40000000,
	Speed = 0,
	BodyHeat = 50000,
	BodyHeatRegenerationRate = 50000,
	SuperStunResistance = true,
	IgnoreAdditionalSpeedMultiplier = true,
	AnimationTimeScale = 1,
	NoAdjustMovementAnimationSpeed = true,
	AnimationDefaultPlayFadeTime = 0.3,
	AnimationDefaultStopFadeTime = 0.3,
	Radius = 1,
	Untargetable = true,
	TakesDamageDealtToOtherEnemies = true,
	KillAllOtherEnemiesOnDeath = true,
	KillAllOtherEnemiesOnDeathStaggerTime = 3,
	KillAllOtherEnemiesOnDeathIgnoreOwnSequence = true,
	SpawnAnimationTime = 26.5,
	SpawnInvulnerabilityTime = 26.5,
	IsBoss = true,
	BossMusicName = "VoidGodBossMusic",
	BossMusicDelay = 22,
	BossHPBarColor = Color3.fromRGB(131, 65, 170),
	StaticSpawnCFrame = CFrame.new(128.677, -106.112, 76.392) * CFrame.Angles(0, 3.141592653589793, 0),
	StaticSpawnCFrameByMap = {
		[Enums.Maps.Genesis] = CFrame.new(-26.323, -5.112, 137.392) * CFrame.Angles(0, 3.141592653589793, 0)
	},
	AbilityNames = {
		Enums.EnemyAbilities.VoidGodSpawnGrab,
		Enums.EnemyAbilities.VoidGodSpawnSlam,
		Enums.EnemyAbilities.VoidGodSummon1,
		Enums.EnemyAbilities.VoidGodSummon2,
		Enums.EnemyAbilities.VoidGodSummon3,
		Enums.EnemyAbilities.VoidGodHandSmashLeft,
		Enums.EnemyAbilities.VoidGodHandSmashRight,
		Enums.EnemyAbilities.VoidGodBlackHole,
		Enums.EnemyAbilities.VoidGodLaserEye,
		Enums.EnemyAbilities.VoidGodAsteroidStorm
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 1.2,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.VoidGodSummon1] = { Disabled = true },
			[Enums.EnemyAbilities.VoidGodSummon2] = { Disabled = true },
			[Enums.EnemyAbilities.VoidGodSummon3] = { Disabled = true },
			[Enums.EnemyAbilities.VoidGodAsteroidStorm] = { DamageMultiplier = 1.05, Cooldown = 70 },
			[Enums.EnemyAbilities.VoidGodBlackHole] = { DamageMultiplier = 2 }
		}
	},
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 42,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 40,
	PlayerCountToAdditionalStatsMap = {
		[2] = { Health = 175000, Shield = 0 },
		[3] = { Health = 400000, Shield = 0 },
		[4] = { Health = 450000, Shield = 0 }
	}
}