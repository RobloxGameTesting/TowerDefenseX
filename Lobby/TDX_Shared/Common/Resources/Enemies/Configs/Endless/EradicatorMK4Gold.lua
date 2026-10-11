local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2500000,
	Shield = 500000,
	CanFalter = true,
	FalterDuration = 1.6,
	StealthDetection = true,
	Speed = 2,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 150000,
	BodyHeatRegenerationRate = 2000,
	FrozenDebounceTime = 8,
	OverrideDisplayName = "Golden Eradicator MK IV",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 4,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "EradicatorMK4GoldBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.EradicatorMK4GoldRage,
		Enums.EnemyAbilities.EradicatorMK4GoldArtilleryShot,
		Enums.EnemyAbilities.EradicatorMK4GoldArtillerySmokeShot,
		Enums.EnemyAbilities.EradicatorMK4GoldRocketBarrage,
		Enums.EnemyAbilities.EradicatorMK4GoldToxicGasGrenade,
		Enums.EnemyAbilities.EradicatorMK4GoldExplosiveGrenade,
		Enums.EnemyAbilities.EradicatorMK4GoldStunGrenade,
		Enums.EnemyAbilities.EradicatorMK4GoldFireGrenade
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 1,
	ForceFaceOutroTime = 1.2,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 3,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	KillBadgeId = 936253947741022
}