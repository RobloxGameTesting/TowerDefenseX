local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 25500,
	BuildDuration = 13,
	UnlockWave = 31,
	PVPCashPerDamageMultiplier = 0.3,
	SendEco = -125,
	Health = 50000,
	Shield = 65000,
	Speed = 1.4,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 1900,
	BodyHeatRegenerationRate = 215,
	Radius = 1.5,
	HeadshotImage = "rbxassetid://139395175242034",
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	IsMiniBoss = true,
	FakeEnemy = false,
	AbilityNames = {
		Enums.EnemyAbilities.CrusherCrush,
		Enums.EnemyAbilities.CrusherSuperCrush,
		Enums.EnemyAbilities.CrusherDamagedTransition
	},
	AbilityBufferTime = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 }
	}
}