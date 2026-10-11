local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 12000,
	Shield = 1000,
	Speed = 3,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 2,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.SlimeBruteSpawnSlimeProjectile },
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RedGloopVeryLarge,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.75 }
	}
}