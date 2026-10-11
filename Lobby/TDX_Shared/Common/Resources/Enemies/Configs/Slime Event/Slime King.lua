local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		StaticEntityType = Enums.StaticEntities.KingSlimeSplat,
		StaticEntityLifetime = 8,
		Delay = 1.2,
		Count = 1,
		PathStudsOffset = -3.5,
		NoSpawnTween = true
	},
	{
		EnemyType = Enums.Enemies.SlimeKingPhase2,
		Delay = 5,
		Count = 1,
		PathStudsOffset = -1.5,
		NoSpawnTween = true
	}
}
return {
	OverrideDisplayName = "Slime King",
	Health = 325000,
	Speed = 2,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "KingSlimeBossMusic",
	NoEventCurrencyDrops = true,
	AbilityNames = {
		Enums.EnemyAbilities.SlimeKingAsteroids,
		Enums.EnemyAbilities.SlimeKingSwordSpin,
		Enums.EnemyAbilities.SlimeKingSwordClang,
		Enums.EnemyAbilities.SlimeKingSwordThrow
	},
	AbilityBufferTime = 2,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BossGreenGloopLarge,
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
	PreloadEnemies = { Enums.Enemies.SlimeKingPhase2 }
}