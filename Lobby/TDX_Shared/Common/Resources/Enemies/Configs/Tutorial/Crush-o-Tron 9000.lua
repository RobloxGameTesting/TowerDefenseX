local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 9000,
	Speed = 1.3,
	BodyHeat = 2500,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	IsMiniBoss = true,
	BossMusicName = "CrushaBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.CrushaRage,
		Enums.EnemyAbilities.CrushaSlam,
		Enums.EnemyAbilities.CrushaSlam_Rage
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	MinimumTimeBeforeSequenceEnds = 3,
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.CrushaSlam_Rage] = { DamageMultiplier = 1 },
			[Enums.EnemyAbilities.CrushaSlam] = { DamageMultiplier = 1 }
		}
	},
	FakeEnemy = false,
	DamageReductionTable = {}
}