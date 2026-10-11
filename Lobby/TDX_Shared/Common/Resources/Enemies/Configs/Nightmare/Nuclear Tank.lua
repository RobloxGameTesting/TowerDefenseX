local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		StaticEntityType = Enums.StaticEntities.NuclearTankRadioactiveSludge,
		Count = 1,
		Delay = 0.55,
		ExactPosition = true,
		StaticEntityLifetime = 6
	}
}
return {
	Health = 80000,
	Shield = 35000,
	Speed = 2.5,
	BodyHeat = 30000,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	AnimationTimeScale = 1,
	DeathAbilityNames = { Enums.EnemyAbilities.NuclearTankDeathExplosion },
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.UltraNightmare] = {
			[Enums.EnemyAbilities.NuclearTankDeathExplosion] = { DamageMultiplier = 2.5 }
		}
	},
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 1,
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 2,
	DeathExplodePartsScale = 1,
	DeathExplodePartsDelay = 0.55,
	DeathEffectsData = {
		{ InstancePath = "DeathExplodePart" }
	},
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 }
	}
}