local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "360 N0SC0P3R",
	Health = 9999,
	Shield = 9999,
	Speed = 4,
	BodyHeat = 999,
	BodyHeatRegenerationRate = 999,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.NoscoperNoscope, Enums.EnemyAbilities.NoscoperNoscope_Shot },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 }
	}
}