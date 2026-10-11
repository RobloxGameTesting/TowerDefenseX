local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 22,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 4.133,
	AnimationName = "Flamethrower",
	FaceTarget = true,
	ForceFaceOverideTime = 0.7,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.PhobeusFlamethrowerBurn },
			Range = 14,
			MinimumRange = 2,
			ArcSpreadAngle = 100,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 800,
			EradicatorFlamethrowerData = {
				StartTime = 1.5,
				StopTime = 3,
				ArcTiming = {
					{ Time = 1.5, Angle = 65 },
					{ Time = 1.767, Angle = 65 },
					{ Time = 2.467, Angle = 0 },
					{ Time = 3, Angle = -65 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 4
			}
		}
	},
	EffectParentInstanceNames = { "Flamethrower" },
	EffectsStartDelay = 0
}