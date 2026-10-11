local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Attack Drone",
	AirUnit = true,
	Health = 20000,
	Shield = 40000,
	Speed = 5,
	NoAdjustMovementAnimationSpeed = true,
	InitialSpeedFraction = 0,
	AccelerationTime = 2.5,
	DecelerationTime = 3,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 500,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	SummonedYOffset = 200,
	SummonedYOffsetVariance = 10,
	SummonedRaiseTime = 3,
	SummonedRaiseTimeVariance = 0.5,
	SummonedRaiseExponent = 3,
	SummonedNoVFX = true,
	SpawnInvulnerabilityTime = 3.25,
	AbilityNames = { Enums.EnemyAbilities.EmperorDroneAttackShoot },
	MaxPathOffset = 1.1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}