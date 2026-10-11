local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 50,
	Cooldown = 30,
	Animated = true,
	Delay = 113 / 60,
	ExecutionTime = 6.95,
	AnimationName = "Flame Breath",
	EffectParentInstanceNames = { "FlameVFX" },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.RedEradicatorMK2FlamethrowerBurn },
			Range = 18,
			ArcSpreadAngle = 115,
			EradicatorFlamethrowerData = {
				StartTime = 113 / 60,
				StopTime = 101 / 30,
				ArcTiming = {
					{
						Time = 113 / 60,
						Angle = -59
					},
					{ Time = 2.1, Angle = -59 },
					{
						Time = 101 / 30,
						Angle = 59
					}
				}
			}
		}
	}
}