local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Calamity",
	OverrideCharacterModelName = "CalamityLowDeathVFX",
	Health = 6666666,
	Speed = 1.4,
	AnimationCalibratedSpeed = 1,
	BodyHeat = 1000000,
	BodyHeatRegenerationRate = 50000,
	HasCustomCode = true,
	OverrideCustomCodeName = "Calamity",
	Radius = 1,
	HoverHeight = 4.34295,
	AnimationTimeScale = 1,
	IsBoss = true,
	AbilityNames = {
		Enums.EnemyAbilities.NightmareCalamity1Rage,
		Enums.EnemyAbilities.NightmareCalamity1Summon,
		Enums.EnemyAbilities.NightmareCalamity1StompFirst,
		Enums.EnemyAbilities.NightmareCalamity1StompPreRage,
		Enums.EnemyAbilities.NightmareCalamity1StompPostRage
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
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}