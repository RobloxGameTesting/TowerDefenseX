local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 63000,
	Speed = 5,
	NoAdjustMovementAnimationSpeed = true,
	AccelerationTime = 1.2,
	DecelerationTime = 1.2,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	HoverHeightVariance = 0.3,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	IsMiniBoss = true,
	AbilityNames = { Enums.EnemyAbilities.CyberDragonFlameBreath },
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.4,
	ForceFaceOutroTime = 0.5,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 }
	}
}