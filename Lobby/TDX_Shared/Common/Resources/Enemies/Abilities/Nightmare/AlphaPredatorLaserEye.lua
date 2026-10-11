local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 30,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 1.633,
	AnimationName = "LaserEye",
	FaceTarget = true,
	ForceFaceOverideTime = 1.2,
	ForceFaceOverideTimeInitial = 0.4,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.AlphaPredatorLaserEyeBurn },
			Range = 120,
			MinimumRange = 10,
			TargetMostExpensiveTower = true,
			BeamEffectHandlingData = {
				{ BeamParentInstanceName = "LaserEye>Beam", BeamDuration = 0.6000000000000001 }
			}
		}
	},
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "Root>SFX>LaserEye" }
}