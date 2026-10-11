local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		StaticEntityType = Enums.StaticEntities.HazmatZombieReworkRadioactiveSludge,
		Count = 1,
		Delay = 0.55,
		ExactPosition = true,
		StaticEntityLifetime = 6
	}
}
return {
	OverrideDisplayName = "Hazmat Zombie",
	Health = 1000,
	NoCash = true,
	Speed = 4,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 80,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 4.2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 3,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 2,
	DeathExplodePartsScale = 1,
	DeathExplodePartsDelay = 0.5,
	DeathEffectsData = {
		{ InstancePath = "DeathExplodePart" }
	},
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DeathAbilityNames = { Enums.EnemyAbilities.HazmatZombieReworkDeathExplosion },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.75 }
	}
}