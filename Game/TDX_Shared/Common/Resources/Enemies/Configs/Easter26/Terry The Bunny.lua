local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2700,
	Shield = 200,
	Speed = 4.4,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 120,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AbilityNames = { Enums.EnemyAbilities.TerryTheBunnyAxeThrow },
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}