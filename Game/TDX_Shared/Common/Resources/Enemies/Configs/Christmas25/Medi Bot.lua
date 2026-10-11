local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -0.17453292519943295, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	Health = 1000,
	Shield = 500,
	Speed = 2.7,
	AnimationCalibratedSpeed = 3,
	AccelerationTime = 0.6,
	DecelerationTime = 1.2,
	BodyHeat = 300,
	BodyHeatRegenerationRate = 100,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath3,
	AbilityNames = {
		Enums.EnemyAbilities.MediBotBuffAbility,
		Enums.EnemyAbilities.MediBotHeal,
		Enums.EnemyAbilities.MediBotPassiveHeal
	},
	TurretConfigs = { v },
	TrackQueriedEnemyData = {
		RetargetOnInvalidation = true,
		QueryRadius = 20,
		EndTravelDistance = 4.5,
		StartTravelDistance = 7.5,
		TravelDistanceVariance = 1
	},
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas25Part1Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		},
		[Enums.Difficulties.Christmas25Part2Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		}
	}
}