local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = false,
	Health = 150000,
	Shield = 600000,
	Speed = 2,
	AnimationCalibratedSpeed = 3.75,
	BodyHeat = 66666,
	BodyHeatRegenerationRate = 6666,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.CalamityReaperSummon },
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}