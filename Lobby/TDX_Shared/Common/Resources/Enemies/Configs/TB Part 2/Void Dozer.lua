local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 175000,
	Shield = 25000,
	StunResistance = true,
	SuperStunResistance = true,
	Speed = 2,
	BodyHeat = 14000,
	BodyHeatRegenerationRate = 900,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	IsBoss = true,
	AbilityNames = { Enums.EnemyAbilities.VoidDozerShieldCharge },
	AbilityBufferTime = 2,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 }
	}
}