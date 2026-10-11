local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 45,
	Animated = true,
	Delay = 1.267,
	ExecutionTime = 5.1499999999999995,
	AnimationName = "Minigun Sweep",
	TriggerRotatingBarrels = true,
	TriggerRotatingBarrelsTime = 3.917,
	EffectParentInstanceNames = { "Minigun" },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.CorruptedEradicatorMK2MinigunSweepDebuff },
			Range = 30,
			ArcSpreadAngle = 45,
			EradicatorFlamethrowerData = {
				StartTime = 1.267,
				StopTime = 2.6,
				ArcTiming = {
					{ Time = 1.267, Angle = 25 },
					{ Time = 1.883, Angle = 25 },
					{ Time = 2.633, Angle = 0 },
					{ Time = 3.5, Angle = -40 },
					{ Time = 3.917, Angle = -40 }
				},
				BufferAngle = 16
			},
			MinimumTargetsInRange = 2
		}
	}
}