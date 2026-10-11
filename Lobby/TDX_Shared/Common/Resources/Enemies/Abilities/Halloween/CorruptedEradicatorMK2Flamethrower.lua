local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 45,
	Animated = true,
	Delay = 1,
	ExecutionTime = 4.617,
	AnimationName = "Flamethrower",
	EffectParentInstanceNames = { "FlameVFX" },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.CorruptedEradicatorMK2Burn },
			Range = 25,
			ArcSpreadAngle = 80,
			EradicatorFlamethrowerData = {
				StartTime = 1,
				StopTime = 3.35,
				ArcTiming = {
					{ Time = 1, Angle = -5 },
					{ Time = 1.383, Angle = -5 },
					{ Time = 1.467, Angle = 0 },
					{ Time = 1.8, Angle = 35 },
					{ Time = 2.4, Angle = 40 },
					{ Time = 2.817, Angle = 0 },
					{ Time = 3.117, Angle = -40 },
					{ Time = 3.35, Angle = -40 }
				},
				BufferAngle = 16
			},
			MinimumTargetsInRange = 4
		}
	}
}