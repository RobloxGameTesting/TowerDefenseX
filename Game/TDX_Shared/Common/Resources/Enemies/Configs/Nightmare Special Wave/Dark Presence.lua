local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 1446965,
	Speed = 4.2,
	BodyHeat = 666666,
	BodyHeatRegenerationRate = 6666,
	Radius = 1,
	AbilityNames = {
		Enums.EnemyAbilities.DarkPresenceSmack,
		Enums.EnemyAbilities.DarkPresenceFireball,
		Enums.EnemyAbilities.DarkPresenceSoulsteal
	},
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	IsMiniBoss = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}