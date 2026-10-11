local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 22,
	Animated = true,
	Delay = 0.833,
	ExecutionTime = 3.8,
	AnimationName = "Flamethrower",
	FaceTarget = true,
	ForceFaceOverideTime = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.AlphaPredatorFlamethrowerBurn },
			Range = 12,
			ArcSpreadAngle = 85,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 800,
			EradicatorFlamethrowerData = {
				StartTime = 0.833,
				StopTime = 2.4,
				ArcTiming = {
					{ Time = 0.833, Angle = 45 },
					{ Time = 1.6, Angle = 45 },
					{ Time = 2, Angle = 0 },
					{ Time = 2.4, Angle = -45 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 3
			}
		}
	},
	EffectParentInstanceNames = { "Flamethrower" },
	EffectsStartDelay = 0,
	InstantPlayEffectParentInstanceNames = { "Root>SFX>Flamethrower" }
}