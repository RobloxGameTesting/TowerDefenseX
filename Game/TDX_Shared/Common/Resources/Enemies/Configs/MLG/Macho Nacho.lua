local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "MACHO NACHO1!!1!!",
	Health = 444444,
	SuperStunResistance = true,
	Speed = 2.4,
	BodyHeat = 333333,
	BodyHeatRegenerationRate = 77777,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.MachoNachoSlam },
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}