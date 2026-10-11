local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 16750,
	Shield = 2500,
	Speed = 6,
	BodyHeat = 4200,
	BodyHeatRegenerationRate = 400,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.9 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Shield = 500 },
		[3] = { Shield = 1250 },
		[4] = { Shield = 3750 }
	}
}