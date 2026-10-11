local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 28000,
	Shield = 3500,
	Speed = 4.4,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3,
	SpawnAnimationTime = 55 / 12,
	SpawnInvulnerabilityTime = 3.5,
	SpawnPathPercentage = 0.28,
	SpawnPathPercentageVariance = 0.15,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AbilityNames = {
		Enums.EnemyAbilities.RavagedPredatorJump,
		Enums.EnemyAbilities.RavagedPredatorJump_Land,
		Enums.EnemyAbilities.RavagedPredatorSlap,
		Enums.EnemyAbilities.RavagedPredatorFire
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.RavagedPredatorFire] = { DamageMultiplier = 2 },
			[Enums.EnemyAbilities.RavagedPredatorSlap] = { DamageMultiplier = 2 },
			[Enums.EnemyAbilities.RavagedPredatorJump_Land] = { DamageMultiplier = 2 }
		}
	},
	FakeEnemy = false,
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	DamageReductionTable = {}
}