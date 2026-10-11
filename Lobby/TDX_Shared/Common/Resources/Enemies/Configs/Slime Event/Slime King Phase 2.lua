local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Evil Slime King",
	Health = 400000,
	Speed = 2.1,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	AnimationTimeScale = 1,
	SpawnAnimationTime = 6,
	SpawnInvulnerabilityTime = 2,
	HasCustomCode = true,
	IsBoss = true,
	BossMusicName = "KingSlimePhase2BossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.SlimeKingLoseLegs,
		Enums.EnemyAbilities.SlimeKingScream,
		Enums.EnemyAbilities.SlimeKingGroundSlamAndSummon,
		Enums.EnemyAbilities.SlimeKingPhase2Jump,
		Enums.EnemyAbilities.SlimeKingPhase2Jump_Land
	},
	AbilityBufferTime = 2,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BossGreenGloopLarge,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 0, Shield = 0 },
		[4] = { Health = 0, Shield = 0 }
	}
}