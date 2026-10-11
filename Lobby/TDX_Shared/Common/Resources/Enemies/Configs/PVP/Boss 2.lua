local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 3000,
	BuildDuration = 9,
	UnlockWave = 16,
	SendEco = 5,
	Health = 6850,
	Shield = 2500,
	Speed = 1.5,
	AnimationCalibratedSpeed = 1.5,
	BodyHeat = 1500,
	BodyHeatRegenerationRate = 85,
	StunResistance = true,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 }
	}
}