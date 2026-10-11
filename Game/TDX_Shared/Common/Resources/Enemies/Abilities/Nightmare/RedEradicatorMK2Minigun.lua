local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 45,
	Animated = true,
	Delay = 8 / 3,
	ExecutionTime = 31 / 3,
	AnimationName = "Minigun",
	EffectParentInstanceNames = { "FootstepSoundsPart" },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.RedEradicatorMK2MinigunDebuff },
			Range = 35,
			ArcSpreadAngle = 105,
			EradicatorFlamethrowerData = {
				StartTime = 8 / 3,
				StopTime = 7.75,
				ArcTiming = {
					{
						Time = 8 / 3,
						Angle = -55
					},
					{
						Time = 223 / 60,
						Angle = -55
					},
					{
						Time = 65 / 12,
						Angle = 0
					},
					{ Time = 7.75, Angle = 55 }
				},
				BufferAngle = 16
			},
			MinimumTargetsInRange = 4
		}
	}
}