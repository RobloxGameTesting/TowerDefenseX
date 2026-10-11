local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Nightmare Void",
	OverrideCharacterModelName = "TB Void",
	Health = 2100000,
	SuperStunResistance = true,
	Speed = 1.4,
	AnimationCalibratedSpeed = 1.2,
	BodyHeat = 1500000,
	BodyHeatRegenerationRate = 600000,
	FrozenDebounceTime = 20,
	FrozenMaximumTime = 0.2,
	ThawTime = 0.1,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "TBNightmareVoidBossMusic",
	BossHPBarColor = Color3.fromRGB(131, 65, 170),
	AbilityNames = {
		Enums.EnemyAbilities.TBNightmareVoidSpawnRageScream,
		Enums.EnemyAbilities.TBNightmareVoidMeteorites,
		Enums.EnemyAbilities.TBNightmareVoidConversion,
		Enums.EnemyAbilities.TBNightmareVoidTowerDestruction,
		Enums.EnemyAbilities.TBNightmareVoidTowerDestructionGolden,
		Enums.EnemyAbilities.TBNightmareVoidStomp,
		Enums.EnemyAbilities.TBNightmareVoidSummon
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
	FadeOutDelay = 3,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 5,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 }
	}
}