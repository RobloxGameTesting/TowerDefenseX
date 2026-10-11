local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	StealthDetection = true,
	SendCost = 28500,
	BuildDuration = 8,
	UnlockWave = 29,
	SendEco = -300,
	Health = 65000,
	Shield = 7000,
	Speed = 2,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 1500,
	BodyHeatRegenerationRate = 300,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = {
		Enums.EnemyAbilities.GestaltSpearJab,
		Enums.EnemyAbilities.GestaltSpearThrow,
		Enums.EnemyAbilities.GestaltRunChargeup
	},
	AbilityBufferTime = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.4 }
	}
}