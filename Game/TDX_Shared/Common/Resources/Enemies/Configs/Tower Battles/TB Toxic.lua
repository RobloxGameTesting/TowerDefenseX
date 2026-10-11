local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Toxic",
	Health = 500,
	Speed = 2.5,
	AnimationCalibratedSpeed = 1.7,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 40,
	Radius = 1,
	AnimationTimeScale = 1,
	DeathAbilityNames = { Enums.EnemyAbilities.TBToxicDeath },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ToxicDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.2 }
	}
}