local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 25,
	Animated = true,
	Delay = 1.3,
	ExecutionTime = 8.467,
	AnimationName = "LaserSweep",
	FaceTarget = true,
	EffectParentInstanceNames = { "LaserSweepContinuous" },
	EffectsStartDelay = 1.3,
	EffectsStopDelay = 6.7,
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>LaserSweep" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.JagerLaserSweepDamage },
			Range = 12,
			MinimumRange = 4,
			ArcSpreadAngle = 120,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 1000,
			EradicatorFlamethrowerData = {
				StartTime = 1.3,
				StopTime = 6.7,
				ArcTiming = {
					{ Time = 1.3, Angle = 0 },
					{ Time = 1.367, Angle = 0 },
					{ Time = 1.8, Angle = -70 },
					{ Time = 2, Angle = -70 },
					{ Time = 2.5, Angle = 0 },
					{ Time = 2.917, Angle = 70 },
					{ Time = 3.083, Angle = 70 },
					{ Time = 3.467, Angle = 0 },
					{ Time = 3.917, Angle = -70 },
					{ Time = 4.117, Angle = -70 },
					{ Time = 4.517, Angle = 0 },
					{ Time = 4.95, Angle = 70 },
					{ Time = 5.067, Angle = 70 },
					{ Time = 5.483, Angle = 0 },
					{ Time = 5.883, Angle = -70 },
					{ Time = 6.1, Angle = -70 },
					{ Time = 6.7, Angle = 0 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 4
			}
		}
	}
}