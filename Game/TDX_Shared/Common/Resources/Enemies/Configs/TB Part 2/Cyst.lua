local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 250,
	Speed = 4,
	BodyHeat = 120,
	BodyHeatRegenerationRate = 20,
	Radius = 0.9,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.15 }
	},
	AbilityNames = { Enums.EnemyAbilities.CystFire, Enums.EnemyAbilities.CystFireAA },
	AbilityBufferTime = 2,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.CystFire] = { DamageMultiplier = 2 },
			[Enums.EnemyAbilities.CystFireAA] = { DamageMultiplier = 1.75 }
		}
	}
}