local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 9.067,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	FaceTarget = true,
	FaceTargetDelay = 8,
	ForceFaceOverideTime = 0.7,
	ForceFaceOverideTimeInitial = 0.55,
	EnemyToTowerRangedDataSequence = {
		{
			TargetPathIfNoTargets = true,
			TowerBuffNames = { Enums.TowerBuffs.EradicatorMK2ReworkRageMinigunDebuff },
			Range = 35,
			ArcSpreadAngle = 150,
			EradicatorFlamethrowerData = {
				StartTime = 9.067,
				StopTime = 13.5,
				ArcTiming = {
					{ Time = 9.067, Angle = 65 },
					{ Time = 9.55, Angle = 65 },
					{ Time = 10.833, Angle = 0 },
					{ Time = 11.933, Angle = -90 },
					{ Time = 12.583, Angle = -180 },
					{ Time = 13.35, Angle = -270 },
					{ Time = 13.5, Angle = -315 }
				},
				BufferAngle = 16
			}
		}
	}
}