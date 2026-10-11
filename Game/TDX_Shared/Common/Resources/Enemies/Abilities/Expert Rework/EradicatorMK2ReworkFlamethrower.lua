local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 30,
	Animated = true,
	AnimationName = "Flamethrower",
	Delay = 2.05,
	ExecutionTime = 8.217,
	FaceTarget = true,
	InstantPlayEffectParentInstanceNames = { "Flamethrower>SFX" },
	EffectParentInstanceNames = { "Flamethrower>FlameLight", "Flamethrower>VFX" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.EradicatorMK2ReworkFlamethrowerBurn },
			Range = 11,
			MinimumRange = 2,
			ArcSpreadAngle = 115,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 800,
			EradicatorFlamethrowerData = {
				StartTime = 2.05,
				StopTime = 4.017,
				ArcTiming = {
					{ Time = 2.05, Angle = -45 },
					{ Time = 2.233, Angle = -45 },
					{ Time = 2.517, Angle = -55 },
					{ Time = 2.683, Angle = -50 },
					{ Time = 2.95, Angle = -45 },
					{ Time = 3.333, Angle = 0 },
					{ Time = 3.733, Angle = 45 },
					{ Time = 3.933, Angle = 90 },
					{ Time = 4.017, Angle = 100 }
				},
				BufferAngle = 12,
				AdditionalRangeForHit = 9
			}
		}
	}
}