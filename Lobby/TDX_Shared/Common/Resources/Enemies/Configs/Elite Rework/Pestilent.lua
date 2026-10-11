local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000,
	Shield = 2500,
	Speed = 2,
	BodyHeat = 8000,
	BodyHeatRegenerationRate = 1800,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.PestilentSummon },
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}