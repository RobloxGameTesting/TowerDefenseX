local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 40,
	Animated = true,
	Delay = 1.1,
	ExecutionTime = 3.833333333333333,
	AnimationName = "Laser Beam",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			TowerBuffNames = { Enums.TowerBuffs.BunnyTank900LaserBeamDamage },
			Range = 20,
			MinimumRange = 2,
			BeamEffectHandlingData = {
				{
					BeamParentInstanceName = "LaserBeams>1",
					BeamDuration = 1.7999999999999998,
					OscillationXZ = 0.4,
					OscillationXZPeriod = 2,
					OscillationY = 0.35,
					OscillationYPeriod = 2.2
				}
			}
		}
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>LaserBeam" }
}