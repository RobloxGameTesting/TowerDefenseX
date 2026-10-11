local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 75,
	Animated = true,
	Delay = 1.6,
	ExecutionTime = 4.7669999999999995,
	AnimationName = "Flamethrower",
	EffectParentInstanceNames = { "FlameVFX" },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.VoidApexPredatorFlamethrowerBurn },
			Range = 22,
			ArcSpreadAngle = 120,
			MinimumTargetsInRange = 4,
			TargetMinimumValue = 1000,
			EradicatorFlamethrowerData = {
				StartTime = 1.65,
				StopTime = 3.55,
				ArcTiming = {
					{ Time = 1.65, Angle = 42.1 },
					{ Time = 1.72, Angle = 69.1 },
					{ Time = 2.1, Angle = 59.4 },
					{ Time = 2.633, Angle = 0 },
					{ Time = 3.017, Angle = -74.1 },
					{ Time = 3.55, Angle = -62.4 }
				}
			}
		}
	}
}