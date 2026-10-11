local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 10500,
	BuildDuration = 5,
	UnlockWave = 31,
	SendEco = -50,
	Health = 8000,
	Shield = 10000,
	Speed = 7.5,
	AnimationCalibratedSpeed = 10,
	BodyHeat = 2000,
	BodyHeatRegenerationRate = 165,
	Radius = 1,
	DeathAbilityNames = { Enums.EnemyAbilities.DisruptorDeath },
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ToxicDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.65 }
	}
}