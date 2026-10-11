local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 5000,
	Shield = 3500,
	Speed = 3.648,
	AnimationCalibratedSpeed = 3.648,
	BodyHeat = 2500,
	BodyHeatRegenerationRate = 300,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.TormentorSummon },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.CorrodedDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 }
	}
}