local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 725,
	Shield = 250,
	Speed = 2,
	BodyHeat = 250,
	BodyHeatRegenerationRate = 15,
	Radius = 1,
	AbilityBufferTime = 3,
	AbilityNames = { Enums.EnemyAbilities.MageFireball, Enums.EnemyAbilities.MageSummon },
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.75 }
	}
}