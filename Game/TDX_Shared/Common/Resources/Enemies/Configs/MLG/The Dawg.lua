local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 99999,
	SuperStunResistance = true,
	Speed = 3,
	BodyHeat = 133337,
	BodyHeatRegenerationRate = 9001,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {},
	{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 }
}