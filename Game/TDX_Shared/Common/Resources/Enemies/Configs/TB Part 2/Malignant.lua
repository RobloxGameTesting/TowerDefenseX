local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000,
	Shield = 1000,
	Speed = 3,
	BodyHeat = 4000,
	BodyHeatRegenerationRate = 400,
	Radius = 1.81,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 1.94,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	},
	AbilityNames = { Enums.EnemyAbilities.MalignantSummon, Enums.EnemyAbilities.MalignantEnemyBuff },
	AbilityBufferTime = 1
}