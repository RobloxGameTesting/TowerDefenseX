local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 275000,
	Speed = 2.4,
	BodyHeat = 19500,
	BodyHeatRegenerationRate = 6000,
	OverrideDisplayName = "---------- MK II",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	IsBoss = true,
	NoBossHPBar = true,
	AbilityNames = {
		Enums.EnemyAbilities.BlueEradicatorMK2Flamethrower,
		Enums.EnemyAbilities.BlueEradicatorMK2RocketBarrage,
		Enums.EnemyAbilities.BlueEradicatorMK2Minigun
	},
	AbilityBufferTime = 2,
	DeathAbilityNames = {},
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.BlueGhostDeath,
	MinimumTimeBeforeSequenceEnds = 7,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 0,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.05 }
	}
}