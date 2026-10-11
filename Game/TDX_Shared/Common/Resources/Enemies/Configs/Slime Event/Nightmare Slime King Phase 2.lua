local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Nightmare Evil Slime King",
	Health = 415000,
	Speed = 2.8,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	AnimationTimeScale = 1,
	SpawnAnimationTime = 6,
	SpawnInvulnerabilityTime = 2,
	HasCustomCode = true,
	OverrideCustomCodeName = Enums.Enemies.SlimeKingPhase2,
	IsBoss = true,
	BossMusicName = "KingSlimePhase2BossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.NightmareSlimeKingLoseLegs,
		Enums.EnemyAbilities.NightmareSlimeKingScream,
		Enums.EnemyAbilities.NightmareSlimeKingGroundSlamAndSummon,
		Enums.EnemyAbilities.NightmareSlimeKingPhase2Jump,
		Enums.EnemyAbilities.NightmareSlimeKingPhase2Jump_Land
	},
	AbilityBufferTime = 2,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BossYellowGloopLarge,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 0, Shield = 0 },
		[4] = { Health = 0, Shield = 0 }
	}
}