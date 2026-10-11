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
	Health = 20000,
	Shield = 20000,
	Speed = 10,
	AnimationCalibratedSpeed = 15,
	AccelerationTime = 0.6,
	DecelerationTime = 1.2,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 2000,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantRobotDeath1,
	IsGiantRobot = true,
	AbilityNames = {
		Enums.EnemyAbilities.GiantMediBotBuffAbility,
		Enums.EnemyAbilities.GiantMediBotHeal,
		Enums.EnemyAbilities.GiantMediBotPassiveHeal
	},
	TurretConfigs = { v },
	TrackQueriedEnemyData = {
		RetargetOnInvalidation = true,
		QueryRadius = 20,
		EndTravelDistance = 7.5,
		StartTravelDistance = 10.5,
		TravelDistanceVariance = 1,
		CustomFilter = function(p)
			return p.IsGiantRobot
		end
	},
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 }
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