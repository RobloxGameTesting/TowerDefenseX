local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 3500,
	Shield = 4500,
	Speed = 5.5,
	AnimationCalibratedSpeed = 6.4,
	BodyHeat = 1200,
	BodyHeatRegenerationRate = 225,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.ThumperJump },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.75 }
	}
}