local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Void Crystallizer",
	Health = 120000,
	Shield = 600000,
	BodyHeat = 20000,
	BodyHeatRegenerationRate = 650,
	Speed = 1,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 1.4000000000000001,
	AbilityNames = {
		Enums.EnemyAbilities.VoidCrystalizerCrystalSummon,
		Enums.EnemyAbilities.VoidCrystalizerCrystalSummon_Spawn
	},
	AbilityBufferTime = 1.5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 }
	},
	FakeEnemy = false
}