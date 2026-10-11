local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		EnemyType = Enums.Enemies.SlimeCaptain9,
		Count = 1,
		ExactPosition = true,
		NoSpawnTween = true
	}
}
return {
	OverrideDisplayName = "Corporal Slime",
	Health = 7500,
	Speed = 3,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	AnimationTimeScale = 1,
	SpawnAnimationTime = 0,
	IsBoss = true,
	BossMusicName = "CaptainSlimeBossMusic",
	NoEventCurrencyDrops = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BossGreenGloopSmall,
	FakeEnemy = false,
	NoHead = true,
	NoTorso = true,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 0, Shield = 0 },
		[4] = { Health = 0, Shield = 0 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.SlimeEventNightmare] = {
			Health = 1000,
			Shield = 1000,
			BodyHeat = 3000000,
			BodyHeatRegenerationRate = 100000
		}
	}
}