local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100000,
	Shield = 30000,
	Speed = 2,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 1200,
	FrozenDebounceTime = 12,
	FrozenMaximumTime = 4,
	ThawTime = 0.2,
	Radius = 1,
	InstantLossIfReachEnd = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 }
	},
	AbilityNames = { Enums.EnemyAbilities.BatteringRamCharge }
}