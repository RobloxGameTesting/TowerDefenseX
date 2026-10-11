local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		EnemyType = Enums.Enemies.SlimeCaptain2,
		Count = 1,
		ExactPosition = true,
		NoSpawnTween = true
	}
}
return {
	OverrideDisplayName = "Captain Slime",
	Health = 100000,
	Speed = 2,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "CaptainSlimeBossMusic",
	NoEventCurrencyDrops = true,
	AbilityNames = {
		Enums.EnemyAbilities.SlimeCaptainArtillery,
		Enums.EnemyAbilities.SlimeCaptainMapSummon,
		Enums.EnemyAbilities.SlimeCaptainGroundShot,
		Enums.EnemyAbilities.SlimeCaptainGroundShot_Heal,
		Enums.EnemyAbilities.SlimeCaptainCannonShot
	},
	AbilityBufferTime = 2,
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BossGreenGloopLarge,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.25 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 7500, Shield = 0 },
		[4] = { Health = 15000, Shield = 0 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.SlimeEventNightmare] = {
			Health = 85000,
			Shield = 25000,
			BodyHeat = 3000000,
			BodyHeatRegenerationRate = 100000
		}
	},
	PreloadEnemies = {
		Enums.Enemies.SlimeCaptain2,
		Enums.Enemies.SlimeCaptain3,
		Enums.Enemies.SlimeCaptain4,
		Enums.Enemies.SlimeCaptain5,
		Enums.Enemies.SlimeCaptain6,
		Enums.Enemies.SlimeCaptain7,
		Enums.Enemies.SlimeCaptain8,
		Enums.Enemies.SlimeCaptain9,
		Enums.Enemies.SlimeCaptain10,
		Enums.Enemies.SlimeCaptain11,
		Enums.Enemies.SlimeCaptain12,
		Enums.Enemies.SlimeCaptain13,
		Enums.Enemies.SlimeGolem
	}
}