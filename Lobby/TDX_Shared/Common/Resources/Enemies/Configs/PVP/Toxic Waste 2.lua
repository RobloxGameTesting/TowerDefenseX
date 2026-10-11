local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 775,
	BuildDuration = 3.25,
	UnlockWave = 15,
	SendEco = 30,
	Health = 500,
	Shield = 200,
	Speed = 3,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 950,
	BodyHeatRegenerationRate = 85,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.4 }
	}
}