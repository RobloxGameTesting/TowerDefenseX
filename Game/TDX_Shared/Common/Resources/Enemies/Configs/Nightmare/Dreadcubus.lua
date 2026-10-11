local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50000,
	Shield = 75000,
	Speed = 2.4,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 80000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5,
	FadeOutRemoveDelay = 5,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.DreadcubusShoot },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}