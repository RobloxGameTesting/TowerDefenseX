local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1100000,
	Speed = 2,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 2500,
	FrozenDebounceTime = 8,
	OverrideDisplayName = "Golden Eradicator MK I Combat",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 3.375,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "EradicatorMKICGoldBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.EradicatorMKICGoldSwordSpin,
		Enums.EnemyAbilities.EradicatorMKICGoldSwordShock,
		Enums.EnemyAbilities.EradicatorMKICGoldRocketStorm,
		Enums.EnemyAbilities.EradicatorMKICGoldRocketStormLongRange,
		Enums.EnemyAbilities.EradicatorMKICGoldLaserCannon,
		Enums.EnemyAbilities.EradicatorMKICGoldEnergyShield,
		Enums.EnemyAbilities.EradicatorMKICGoldSwordEarthquake,
		Enums.EnemyAbilities.EradicatorMKICGoldLaserSweep,
		Enums.EnemyAbilities.EradicatorMKICGoldRage
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.45,
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
	ShieldModelName = "ForceField",
	ToggleShieldModelIfHasShield = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	KillBadgeId = 1922537028219041
}