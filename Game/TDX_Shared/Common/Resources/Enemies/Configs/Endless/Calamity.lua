local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 6666666,
	Speed = 1,
	AnimationCalibratedSpeed = 1,
	BodyHeat = 666666,
	BodyHeatRegenerationRate = 46666,
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 4.34295,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "CalamityBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.CalamityRage,
		Enums.EnemyAbilities.CalamitySummon,
		Enums.EnemyAbilities.CalamityStompFirst,
		Enums.EnemyAbilities.CalamityStompPreRage,
		Enums.EnemyAbilities.CalamityStompPostRage
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.65,
	ForceFaceOutroTime = 1.2,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 8,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 0,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	},
	KillBadgeId = 1919563277273775
}