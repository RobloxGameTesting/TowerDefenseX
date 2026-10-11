local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 300000,
	Speed = 2.4,
	BodyHeat = 39500,
	BodyHeatRegenerationRate = 900,
	FrozenDebounceTime = 10,
	FrozenMaximumTime = 10,
	ThawTime = 0.6,
	OverrideDisplayName = "Eradicator MK II",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "EradicatorMK2BossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.EradicatorMK2RocketBarrage,
		Enums.EnemyAbilities.EradicatorMK2Minigun,
		Enums.EnemyAbilities.EradicatorMK2Flamethrower,
		Enums.EnemyAbilities.EradicatorMK2Rage,
		Enums.EnemyAbilities.EradicatorMK2StealthMode
	},
	AbilityBufferTime = 2,
	DeathAbilityNames = {},
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	MinimumTimeBeforeSequenceEnds = 7,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 3,
	FadeOutRemoveDelay = 12,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}