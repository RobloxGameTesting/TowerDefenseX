local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 140000,
	Speed = 2.4,
	BodyHeat = 7000,
	BodyHeatRegenerationRate = 250,
	FrozenDebounceTime = 8,
	FrozenMaximumTime = 10,
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 3.219886363636364,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "EradicatorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.EradicatorRocketBarrage,
		Enums.EnemyAbilities.EradicatorRocketBarrageLarge,
		Enums.EnemyAbilities.EradicatorSwordSlash,
		Enums.EnemyAbilities.EradicatorSwordShock,
		Enums.EnemyAbilities.EradicatorSwordSlam,
		Enums.EnemyAbilities.EradicatorFlamethrower,
		Enums.EnemyAbilities.EradicatorRage
	},
	AbilityBufferTime = 5,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	MinimumTimeBeforeSequenceEnds = 4.5,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}