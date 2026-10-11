local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 25,
	Cooldown = 30,
	Animated = true,
	Delay = 2.05,
	ExecutionTime = 5.3,
	AnimationName = "MinigunArc",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.X2FighterMinigunArcDebuff },
			Range = 12,
			MinimumRange = 4,
			ArcSpreadAngle = 85,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 500,
			EradicatorFlamethrowerData = {
				StartTime = 2.05,
				StopTime = 4.15,
				ArcTiming = {
					{ Time = 2.05, Angle = -45 },
					{ Time = 2.35, Angle = -45 },
					{ Time = 3.4, Angle = 0 },
					{ Time = 4.15, Angle = 45 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 3
			}
		}
	},
	EffectParentInstanceNames = { "MinigunArc" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>MinigunArc" }
}