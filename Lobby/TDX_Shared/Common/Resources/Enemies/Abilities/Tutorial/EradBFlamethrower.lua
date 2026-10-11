local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 25,
	Animated = true,
	Delay = 1.133,
	ExecutionTime = 5.133,
	AnimationName = "Flamethrower",
	FaceTarget = true,
	ForceFaceOverideTime = 0.7,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.EradBFlamethrowerBurn },
			Range = 14,
			MinimumRange = 2,
			ArcSpreadAngle = 70,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 800,
			EradicatorFlamethrowerData = {
				StartTime = 1.133,
				StopTime = 2.7,
				ArcTiming = {
					{ Time = 1.133, Angle = -30 },
					{ Time = 1.417, Angle = -40 },
					{ Time = 2.067, Angle = 0 },
					{ Time = 2.65, Angle = 40 },
					{ Time = 2.7, Angle = 40 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 4
			}
		}
	},
	EffectParentInstanceNames = { "FlameVFX" },
	EffectsStartDelay = 0
}