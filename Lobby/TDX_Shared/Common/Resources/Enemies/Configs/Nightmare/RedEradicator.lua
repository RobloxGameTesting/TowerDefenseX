local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local RedEradicator = {
	Health = 535259,
	Shield = 100000,
	Speed = 3,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 62000,
	BodyHeatRegenerationRate = 999,
	OverrideDisplayName = "Clone MK I",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 3.219886363636364,
	AnimationTimeScale = 1,
	IsBoss = true,
	NoBossHPBar = true,
	AbilityNames = {
		Enums.EnemyAbilities.EradicatorRocketBarrage,
		Enums.EnemyAbilities.EradicatorRocketBarrageLarge,
		Enums.EnemyAbilities.EradicatorSwordSlash,
		Enums.EnemyAbilities.EradicatorSwordShock,
		Enums.EnemyAbilities.EradicatorSwordSlam,
		Enums.EnemyAbilities.EradicatorFlamethrower
	},
	AbilityBufferTime = 5,
	DifficultyToAbilityStatOverridesMap = 0,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	NoPathOffset = true,
	RotationOffset = 0,
	MinimumTimeBeforeSequenceEnds = 4.5,
	FakeEnemy = false,
	DamageReductionTable = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.Nightmare] = {
		[Enums.EnemyAbilities.EradicatorRocketBarrage] = { DamageMultiplier = 4 },
		[Enums.EnemyAbilities.EradicatorRocketBarrageLarge] = { DamageMultiplier = 4 },
		[Enums.EnemyAbilities.EradicatorSwordSlash] = { DamageMultiplier = 5 },
		[Enums.EnemyAbilities.EradicatorSwordShock] = { DamageMultiplier = 1.2 },
		[Enums.EnemyAbilities.EradicatorSwordSlam] = { DamageMultiplier = 5 },
		[Enums.EnemyAbilities.EradicatorFlamethrower] = { DamageMultiplier = 6 }
	}
}
local UltraNightmare = Enums.Difficulties.UltraNightmare
difficultyToAbilityStatOverridesMap[UltraNightmare] = {
	[Enums.EnemyAbilities.EradicatorRocketBarrage] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorRocketBarrageLarge] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorSwordSlash] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorSwordShock] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorSwordSlam] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorFlamethrower] = { DamageMultiplier = 1.2 }
}
local Test = Enums.Difficulties.Test
difficultyToAbilityStatOverridesMap[Test] = {
	[Enums.EnemyAbilities.EradicatorRocketBarrage] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorRocketBarrageLarge] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorSwordSlash] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorSwordShock] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorSwordSlam] = { DamageMultiplier = 1.2 },
	[Enums.EnemyAbilities.EradicatorFlamethrower] = { DamageMultiplier = 1.2 }
}
RedEradicator.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
RedEradicator.RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
RedEradicator.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 }
}
return RedEradicator