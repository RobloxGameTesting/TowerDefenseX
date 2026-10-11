local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Nightmare Corrupted Predator",
	OverrideCharacterModelName = Enums.Enemies.CorruptedPredator,
	Health = 50000,
	Speed = 2.6,
	AnimationCalibratedSpeed = 2.6,
	BodyHeat = 2250,
	BodyHeatRegenerationRate = 600,
	Radius = 1,
	AnimationTimeScale = 1,
	IsMiniBoss = true,
	BossMusicName = "CorruptedPredatorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.CorruptedPredatorNightmareScream,
		Enums.EnemyAbilities.CorruptedPredatorNightmareConvert,
		Enums.EnemyAbilities.CorruptedPredatorNightmareShot,
		Enums.EnemyAbilities.CorruptedPredatorNightmareLeechShot,
		Enums.EnemyAbilities.CorruptedPredatorNightmareLeechSwarm,
		Enums.EnemyAbilities.CorruptedPredatorNightmareDash
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}