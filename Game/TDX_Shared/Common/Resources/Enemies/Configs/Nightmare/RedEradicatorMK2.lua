local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 474441,
	Shield = 100000,
	Speed = 3.4,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 80000,
	BodyHeatRegenerationRate = 999,
	OverrideDisplayName = "Clone MK II",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	IsBoss = true,
	NoBossHPBar = true,
	AbilityNames = {
		Enums.EnemyAbilities.RedEradicatorMK2Flamethrower,
		Enums.EnemyAbilities.RedEradicatorMK2RocketBarrage,
		Enums.EnemyAbilities.RedEradicatorMK2Minigun
	},
	AbilityBufferTime = 2,
	DeathAbilityNames = {},
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.RedGhostDeath,
	MinimumTimeBeforeSequenceEnds = 7,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 0,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 }
	}
}