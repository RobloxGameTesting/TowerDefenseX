local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 25,
	Cooldown = 40,
	Animated = true,
	Delay = 2.1,
	ExecutionTime = 7.1,
	AnimationName = "LaserHands",
	FaceTarget = true,
	ForceFaceOverideTime = 0.5,
	ForceFaceOverideTimeInitial = 1.1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.BunnyOTronLaserHandsDebuff },
			Range = 80,
			MinimumRange = 5,
			TargetMostExpensiveTower = true,
			TargetMinimumValue = 20000,
			BeamEffectHandlingData = {
				{ BeamParentInstanceName = "LaserHands>Beam", BeamDuration = 3.9999999999999996 }
			}
		}
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>LaserHands" }
}