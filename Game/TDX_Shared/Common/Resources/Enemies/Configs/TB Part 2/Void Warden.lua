local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50000,
	Shield = 25000,
	StealthDetection = true,
	Speed = 2,
	BodyHeat = 50000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	AnimationCalibratedSpeed = 3.5,
	SpawnPathPercentage = 0.25,
	SpawnPathPercentageVariance = 0.1,
	SpawnAnimationTime = 2.733,
	SpawnInvulnerabilityTime = 3.133,
	IsMiniBoss = true,
	AbilityNames = { Enums.EnemyAbilities.VoidWardenCrystalShot, Enums.EnemyAbilities.VoidWardenCrystalShotAir },
	AbilityBufferTime = 3,
	DeathAbilityNames = { Enums.EnemyAbilities.VoidWardenDeathExplosion },
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.5,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.VoidWardenCrystalShot] = { DamageMultiplier = 1.5 },
			[Enums.EnemyAbilities.VoidWardenCrystalShotAir] = { DamageMultiplier = 3 }
		}
	},
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	DeathExplodePartsScale = 1,
	DeathExplodePartsDelay = 3.666,
	DeathEffectsData = {
		{ InstancePath = "DeathExplodePart" }
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 }
	}
}