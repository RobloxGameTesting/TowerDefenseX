local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		StaticEntityType = Enums.StaticEntities.NightmareKingSlimeSplat,
		StaticEntityLifetime = 8,
		Delay = 1.2,
		Count = 1,
		PathStudsOffset = -3.5,
		NoSpawnTween = true
	},
	{
		EnemyType = Enums.Enemies.NightmareSlimeKingPhase2,
		Delay = 5,
		Count = 1,
		PathStudsOffset = -1.5,
		NoSpawnTween = true
	}
}
return {
	OverrideDisplayName = "Nightmare Slime King",
	Health = 382000,
	Speed = 2.4,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "KingSlimeBossMusic",
	NoEventCurrencyDrops = true,
	AbilityNames = {
		Enums.EnemyAbilities.NightmareSlimeKingAsteroids,
		Enums.EnemyAbilities.NightmareSlimeKingSwordThrow,
		Enums.EnemyAbilities.NightmareSlimeKingSwordSpin,
		Enums.EnemyAbilities.NightmareSlimeKingSwordClang
	},
	AbilityBufferTime = 2,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BossYellowGloopLarge,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 0, Shield = 0 },
		[4] = { Health = 0, Shield = 0 }
	},
	PreloadEnemies = { Enums.Enemies.NightmareSlimeKingPhase2 }
}