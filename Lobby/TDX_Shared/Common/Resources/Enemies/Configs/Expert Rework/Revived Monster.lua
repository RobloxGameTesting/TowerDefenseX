local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 32000,
	Speed = 2,
	BodyHeat = 3200,
	BodyHeatRegenerationRate = 130,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.45 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Shield = 1000 },
		[3] = { Shield = 3000 },
		[4] = { Shield = 6000 }
	}
}