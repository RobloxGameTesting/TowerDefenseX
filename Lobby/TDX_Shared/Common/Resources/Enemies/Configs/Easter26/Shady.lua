local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1111,
	Shield = 1111,
	Speed = 15,
	BodyHeat = 2500,
	BodyHeatRegenerationRate = 950,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AbilityNames = { Enums.EnemyAbilities.ShadyFrenzy },
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	},
	GhostlyUnit = true
}