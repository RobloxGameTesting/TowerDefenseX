local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 35000,
	Shield = 70000,
	Speed = 2,
	AnimationCalibratedSpeed = 2.14,
	BodyHeat = 12000,
	BodyHeatRegenerationRate = 700,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.CorruptedGoldenCommandoMinigun },
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.CorruptedGoldenCommandoMinigun] = { DamageMultiplier = 1.25 }
		}
	},
	HasAttack = false,
	StealthDetection = false,
	NoPathOffset = false,
	RotationOffset = CFrame.new(),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.9 }
	}
}