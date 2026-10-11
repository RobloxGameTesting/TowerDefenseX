local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 25,
	Animated = true,
	Delay = 2,
	ExecutionTime = 6.467,
	AnimationName = "Flamethrower",
	FaceTarget = true,
	ForceFaceOverideTime = 0.7,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.XJuggernautFlamethrowerBurn },
			Range = 10,
			MinimumRange = 2,
			ArcSpreadAngle = 80,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 350,
			EradicatorFlamethrowerData = {
				StartTime = 2,
				StopTime = 5,
				ArcTiming = {
					{ Time = 2, Angle = 0 },
					{ Time = 2.767, Angle = 0 },
					{ Time = 3.117, Angle = -45 },
					{ Time = 3.483, Angle = -45 },
					{ Time = 4.133, Angle = 15 },
					{ Time = 4.417, Angle = 45 },
					{ Time = 5, Angle = 5 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 3
			}
		}
	},
	EffectParentInstanceNames = { "Flamethrower" },
	EffectsStartDelay = 0
}