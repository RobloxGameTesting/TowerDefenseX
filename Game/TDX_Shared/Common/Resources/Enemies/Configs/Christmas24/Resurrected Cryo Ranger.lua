local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 500,
	Speed = 6,
	AnimationCalibratedSpeed = 6,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 30,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.ResurrectedCryoRangerGrenade },
	ForceFaceIntroTime = 0.35,
	ForceFaceOutroTime = 0.25,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}