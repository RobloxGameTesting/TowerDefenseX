local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 45,
	Animated = true,
	Delay = 1.167,
	ExecutionTime = 5.3,
	AnimationName = "ChaingunStrafe",
	EffectParentInstanceNames = { "ChaingunStrafeVFX" },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.DreadnoughtContemptorStrafeDebuff },
			Range = 22,
			ArcSpreadAngle = 90,
			EradicatorFlamethrowerData = {
				StartTime = 1.167,
				StopTime = 4,
				ArcTiming = {
					{ Time = 1.167, Angle = 45 },
					{ Time = 1.417, Angle = 45 },
					{ Time = 2.583, Angle = 0 },
					{ Time = 2.583, Angle = 0 },
					{ Time = 3.167, Angle = 0 },
					{ Time = 4, Angle = -45 }
				},
				BufferAngle = 16
			},
			MinimumTargetsInRange = 4
		}
	}
}