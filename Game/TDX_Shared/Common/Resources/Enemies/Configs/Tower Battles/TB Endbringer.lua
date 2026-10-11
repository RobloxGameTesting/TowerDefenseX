local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Endbringer",
	Health = 150000,
	Speed = 2.2,
	AnimationCalibratedSpeed = 2.2,
	BodyHeat = 999999,
	BodyHeatRegenerationRate = 99999,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.TBEndbringerSlam, Enums.EnemyAbilities.TBEndbringerThrow },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.6 }
	}
}