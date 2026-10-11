local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 20000,
	Shield = 18000,
	Speed = 2.1,
	BodyHeat = 8000,
	BodyHeatRegenerationRate = 250,
	Radius = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.6 }
	},
	AbilityNames = { Enums.EnemyAbilities.IronBastionSlam, Enums.EnemyAbilities.IronBastionHamerThrow },
	AbilityBufferTime = 2
}