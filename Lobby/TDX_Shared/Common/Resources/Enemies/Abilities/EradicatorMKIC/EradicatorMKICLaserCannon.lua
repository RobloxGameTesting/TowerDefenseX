local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 7,
	Cooldown = 16,
	Animated = true,
	Delay = 0.775,
	ExecutionTime = 5.0329999999999995,
	AnimationName = "Laser Cannon",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.EradicatorMKICLaserCannonBurn },
			Range = 40,
			MinimumRange = 10,
			TargetMostExpensiveTower = true,
			BeamEffectHandlingData = {
				{ BeamParentInstanceName = "LaserEyeBeamPartRight", BeamDuration = 0.9 },
				{ BeamParentInstanceName = "LaserEyeBeamPartLeft", BeamDuration = 0.9 },
				{
					BeamParentInstanceName = "LaserEyeBeamPartRightPart2",
					BeamDuration = 1.75,
					BeamOverrideDelay = 1.9
				},
				{
					BeamParentInstanceName = "LaserEyeBeamPartLeftPart2",
					BeamDuration = 1.75,
					BeamOverrideDelay = 1.9
				}
			}
		}
	},
	EffectParentInstanceNames = { "LaserEyeEffectsPart" }
}