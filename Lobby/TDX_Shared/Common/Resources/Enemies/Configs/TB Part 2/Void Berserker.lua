local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 72000,
	Shield = 12000,
	Speed = 6,
	BodyHeat = 6000,
	BodyHeatRegenerationRate = 500,
	Radius = 1.41,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 8.21,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.VoidBerserkerAbility, Enums.EnemyAbilities.VoidBerserkerAbility_PathEntity },
	AbilityBufferTime = 2,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.5 }
	}
}