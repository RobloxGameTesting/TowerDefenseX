local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 35,
	Animated = true,
	Delay = 1.6,
	ExecutionTime = 3.7159999999999997,
	AnimationName = "LaserEye",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.ApexPredatorLaserEyeBurn },
			Range = 120,
			MinimumRange = 10,
			TargetMostExpensiveTower = true,
			BeamEffectHandlingData = {
				{ BeamParentInstanceName = "LaserEyeBeamPart", BeamDuration = 0.867 }
			}
		}
	},
	EffectParentInstanceNames = { "LaserEyeEffectsPart" }
}