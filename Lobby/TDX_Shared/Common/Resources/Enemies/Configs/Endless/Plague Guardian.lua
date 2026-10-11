local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000,
	Speed = 2.2,
	AnimationCalibratedSpeed = 1.2,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	HoverHeight = 2.5056000000000003,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.PlagueGuardianSummon },
	AbilityBufferTime = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.67 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.7 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 }
	}
}