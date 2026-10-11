local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideCharacterModelName = Enums.Enemies.EradicatorMK4,
	Health = 1000000,
	Shield = 150000,
	CanFalter = true,
	FalterDuration = 1.6,
	StealthDetection = true,
	Speed = 2,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 50000,
	BodyHeatRegenerationRate = 500,
	OverrideDisplayName = "Eradicator MK IV",
	HasCustomCode = true,
	OverrideCustomCodeName = Enums.Enemies.EradicatorMK4,
	Radius = 1,
	HoverHeight = 4,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "EradicatorMK4BossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.EradicatorMK4NightmareRage,
		Enums.EnemyAbilities.EradicatorMK4ArtilleryShot,
		Enums.EnemyAbilities.EradicatorMK4ArtillerySmokeShot,
		Enums.EnemyAbilities.EradicatorMK4RocketBarrage,
		Enums.EnemyAbilities.EradicatorMK4NightmareToxicGasGrenade,
		Enums.EnemyAbilities.EradicatorMK4ExplosiveGrenade,
		Enums.EnemyAbilities.EradicatorMK4StunGrenade,
		Enums.EnemyAbilities.EradicatorMK4FireGrenade
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