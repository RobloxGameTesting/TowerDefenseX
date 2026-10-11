local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 8000,
	Shield = 2000,
	Speed = 5,
	NoAdjustMovementAnimationSpeed = true,
	AccelerationTime = 0.4,
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
	SummonedRaiseTime = 3.5,
	SummonedRaiseTimeVariance = 0.5,
	SummonedRaiseExponent = 3,
	SummonedNoVFX = true,
	SpawnInvulnerabilityTime = 3.75,
	AbilityNames = { Enums.EnemyAbilities.HealingDroneHeal },
	TurretConfigs = {
		{
			ModelName = "Turret",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "Gun",
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 0,
						MinRotationX = -65
					}
				}
			}
		}
	},
	MaxPathOffset = 1.1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}