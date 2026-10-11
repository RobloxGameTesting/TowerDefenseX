local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 125,
	BuildDuration = 4,
	UnlockWave = 5,
	SendEco = 12,
	Health = 65,
	Shield = 20,
	Speed = 2.4,
	AnimationCalibratedSpeed = 1.5,
	BodyHeat = 60,
	BodyHeatRegenerationRate = 6,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.2 }
	}
}