local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local ToiletJohnBoss = {
	Health = 3000000,
	Speed = 1,
	BodyHeat = 70000,
	BodyHeatRegenerationRate = 6000,
	OverrideDisplayName = "SUPER REVIVED TOLIET JOHN MK I9X",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "ToiletBossMusic",
	AbilityNames = { Enums.EnemyAbilities.ToiletJohnBossMinigun, Enums.EnemyAbilities.ToiletJohnBossRocketBarrage },
	AbilityBufferTime = 2,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 1.2,
	DifficultyToAbilityStatOverridesMap = 0,
	NoPathOffset = true,
	RotationOffset = 0,
	MinimumTimeBeforeSequenceEnds = 3,
	DeathEffect = 0,
	FakeEnemy = false,
	DamageReductionTable = 0,
	DifficultyToStatOverrideMap = 0
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.MLGNightmare] = {
		[Enums.EnemyAbilities.ToiletJohnBossMinigun] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 3
		},
		[Enums.EnemyAbilities.ToiletJohnBossRocketBarrage] = {
			StartingCooldown = nil,
			Cooldown = nil,
			StartingCooldownVariance = nil,
			CooldownVariance = nil,
			DamageMultiplier = 3
		}
	}
}
local TBPart2Voidmare = Enums.Difficulties.TBPart2Voidmare
difficultyToAbilityStatOverridesMap[TBPart2Voidmare] = {
	[Enums.EnemyAbilities.ToiletJohnBossMinigun] = { DamageMultiplier = 5 },
	[Enums.EnemyAbilities.ToiletJohnBossRocketBarrage] = { DamageMultiplier = 6, Cooldown = 7 }
}
ToiletJohnBoss.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
ToiletJohnBoss.RotationOffset = CFrame.Angles(0, 0, 0)
ToiletJohnBoss.DeathEffect = Enums.DeathEffects.ToiletBossDeath
ToiletJohnBoss.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
}
ToiletJohnBoss.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.MLGNightmare] = { StealthDetection = true }
}
return ToiletJohnBoss