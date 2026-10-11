local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 30000,
	Shield = 20000,
	Speed = 6,
	BodyHeat = 7000,
	BodyHeatRegenerationRate = 350,
	Radius = 1.34,
	AlwaysStealthed = true,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 6.75,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.ShadyBossThrow },
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.ShadyBossThrow] = {
				DamageMultiplier = 3,
				Cooldown = 8,
				StartingCooldown = 1,
				CooldownVariance = 0
			}
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.85 }
	}
}