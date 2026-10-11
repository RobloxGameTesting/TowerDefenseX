local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2500,
	Shield = 1200,
	Speed = 4,
	BodyHeat = 1200,
	BodyHeatRegenerationRate = 150,
	Radius = 0.89,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3.16,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathAbilityNames = { Enums.EnemyAbilities.SlagDeathDebuff },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Toxic, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.3 }
	}
}