local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 22,
	Animated = true,
	Delay = 0.55,
	ExecutionTime = 2.8,
	AnimationName = "LaserArc",
	FaceTarget = true,
	ForceFaceOverideTime = 0.5,
	ForceFaceOverideTimeInitial = 0.25,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.AlphaPredatorLaserArcBurn },
			Range = 12,
			MinimumRange = 8,
			ArcSpreadAngle = 75,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 500,
			EradicatorFlamethrowerData = {
				StartTime = 0.55,
				StopTime = 1.7,
				ArcTiming = {
					{ Time = 0.55, Angle = -40 },
					{ Time = 0.75, Angle = -40 },
					{ Time = 1, Angle = 0 },
					{ Time = 1.1, Angle = 0 },
					{ Time = 1.5, Angle = 40 },
					{ Time = 1.7, Angle = 40 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 3
			}
		}
	},
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "Root>SFX>LaserArc" }
}