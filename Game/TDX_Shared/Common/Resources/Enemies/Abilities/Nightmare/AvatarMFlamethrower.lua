local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 22,
	Animated = true,
	Delay = 1.333,
	ExecutionTime = 10.267,
	AnimationName = "Flamethrower",
	FaceTarget = true,
	ForceFaceOverideTime = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.AvatarMFlamethrowerBurn },
			Range = 12,
			ArcSpreadAngle = 100,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 800,
			EradicatorFlamethrowerData = {
				StartTime = 1.333,
				StopTime = 8.5,
				ArcTiming = {
					{ Time = 1.333, Angle = 0 },
					{ Time = 1.883, Angle = 0 },
					{ Time = 2.583, Angle = -45 },
					{ Time = 2.75, Angle = -45 },
					{ Time = 3.8, Angle = 45 },
					{ Time = 3.983, Angle = 45 },
					{ Time = 4.817, Angle = -45 },
					{ Time = 5.133, Angle = -45 },
					{ Time = 6.183, Angle = 45 },
					{ Time = 6.3, Angle = 45 },
					{ Time = 7.183, Angle = -45 },
					{ Time = 7.467, Angle = -45 },
					{ Time = 8.05, Angle = 0 },
					{ Time = 8.5, Angle = 0 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 3
			}
		}
	},
	EffectParentInstanceNames = { "Flamethrower" },
	EffectsStartDelay = 0
}