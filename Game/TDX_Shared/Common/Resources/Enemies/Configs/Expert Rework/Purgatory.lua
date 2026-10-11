local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000,
	Speed = 2.8,
	BodyHeat = 1800,
	BodyHeatRegenerationRate = 100,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	AbilityNames = { Enums.EnemyAbilities.PurgatoryMissileAttack, Enums.EnemyAbilities.PurgatoryAntiAirMissileAttack },
	AbilityBufferTime = 2,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.MLGNightmare] = {
			[Enums.EnemyAbilities.PurgatoryMissileAttack] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 10
			},
			[Enums.EnemyAbilities.PurgatoryAntiAirMissileAttack] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 10
			}
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.4 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.MLGNightmare] = { StealthDetection = true }
	}
}