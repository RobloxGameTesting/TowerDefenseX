local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 75000,
	Shield = 120000,
	Speed = 2.7,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 90000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	HasCustomCode = true,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5,
	FadeOutRemoveDelay = 5,
	FakeEnemy = false,
	AbilityNames = {
		Enums.EnemyAbilities.CybercubusShoot,
		Enums.EnemyAbilities.CybercubusSmashGroundSingle,
		Enums.EnemyAbilities.CybercubusSmashGroundDouble,
		Enums.EnemyAbilities.CybercubusArmorBreak,
		Enums.EnemyAbilities.CybercubusArmorBreak_Invulnerable
	},
	AbilityBufferTime = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}