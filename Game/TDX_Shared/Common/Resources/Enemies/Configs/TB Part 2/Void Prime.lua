local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local VoidPrime = {
	Health = 3200000,
	SuperStunResistance = true,
	KnockbackResistance = true,
	Speed = 2.5,
	AnimationCalibratedSpeed = 2.64,
	BodyHeat = 1000000,
	BodyHeatRegenerationRate = 350000,
	Radius = 1,
	AnimationTimeScale = 1,
	HasCustomCode = true,
	SpawnPathPercentage = 0.075,
	SpawnPathPercentageVariance = 0.025,
	SpawnAnimationTime = 6.133,
	SpawnInvulnerabilityTime = 8.517,
	IsBoss = true,
	BossMusicName = "VoidPrimeBossMusic",
	BossHPBarColor = Color3.fromRGB(131, 65, 170),
	AbilityNames = {
		Enums.EnemyAbilities.VoidPrimeSwordSlam,
		Enums.EnemyAbilities.VoidPrimeStomp,
		Enums.EnemyAbilities.VoidPrimeBoomerang,
		Enums.EnemyAbilities.VoidPrimeClawCalling,
		Enums.EnemyAbilities.VoidPrimeRage,
		Enums.EnemyAbilities.VoidPrimeEmpBlade,
		Enums.EnemyAbilities.VoidPrimeBladeSpam,
		Enums.EnemyAbilities.VoidPrimeExecute,
		Enums.EnemyAbilities.VoidPrimeVoidCalling,
		Enums.EnemyAbilities.VoidPrimeBladeSpin
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.65,
	ForceFaceOutroTime = 1.2
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.TBPart2Casual] = {
		[Enums.EnemyAbilities.VoidPrimeStomp] = { Cooldown = 40, DamageMultiplier = 0.15 },
		[Enums.EnemyAbilities.VoidPrimeClawCalling] = { Cooldown = 40, DamageMultiplier = 0.1 },
		[Enums.EnemyAbilities.VoidPrimeSwordSlam] = { DamageMultiplier = 0.1 },
		[Enums.EnemyAbilities.VoidPrimeBoomerang] = { DamageMultiplier = 0.05 },
		[Enums.EnemyAbilities.VoidPrimeBladeSpam] = { DamageMultiplier = 0.1 },
		[Enums.EnemyAbilities.VoidPrimeVoidCalling] = { Cooldown = 70 },
		[Enums.EnemyAbilities.VoidPrimeBladeSpin] = { DamageMultiplier = 0.005, Cooldown = 120 },
		[Enums.EnemyAbilities.VoidPrimeExecute] = { Cooldown = 35 }
	}
}
local TBPart2Nightmare = Enums.Difficulties.TBPart2Nightmare
difficultyToAbilityStatOverridesMap[TBPart2Nightmare] = {
	[Enums.EnemyAbilities.VoidPrimeBladeSpam] = { Cooldown = 20 },
	[Enums.EnemyAbilities.VoidPrimeExecute] = { Cooldown = 7 }
}
VoidPrime.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
VoidPrime.FootstepEffectInstanceNames = "FootstepsSFX"
VoidPrime.NoPathOffset = true
VoidPrime.RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
VoidPrime.MinimumTimeBeforeSequenceEnds = 8
VoidPrime.FakeEnemy = false
VoidPrime.FadeOutOnDeath = true
VoidPrime.FadeOutDelay = 3
VoidPrime.FadeOutCustomTime = 1
VoidPrime.FadeOutRemoveDelay = 5
VoidPrime.KillBadgeId = 4343659851518501
VoidPrime.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
	{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 }
}
VoidPrime.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.TBPart2Casual] = { Health = 2000000 },
	[Enums.Difficulties.TBPart2Nightmare] = { Health = 4000000 }
}
return VoidPrime