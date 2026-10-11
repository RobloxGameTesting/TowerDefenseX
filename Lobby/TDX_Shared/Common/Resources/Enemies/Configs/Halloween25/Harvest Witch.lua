local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 80000,
	Shield = 50000,
	Speed = 2,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 450,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.CorruptedDeath,
	AbilityNames = { Enums.EnemyAbilities.HarvestWitchSpell },
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.5 }
	}
}