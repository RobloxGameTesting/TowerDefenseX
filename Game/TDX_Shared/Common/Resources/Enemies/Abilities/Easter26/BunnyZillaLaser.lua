local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 14,
	Animated = true,
	Delay = 67 / 30,
	ExecutionTime = 71 / 6,
	AnimationName = "Laser",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.BunnyZillaLaserDamage },
			Range = 19,
			MinimumRange = 13,
			ArcSpreadAngle = 90,
			EradicatorFlamethrowerData = {
				StartTime = 67 / 30,
				StopTime = 10.45,
				ArcTiming = {
					{
						Time = 67 / 30,
						Angle = -45
					},
					{
						Time = 761 / 120,
						Angle = 45
					},
					{ Time = 10.45, Angle = -45 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 4
			}
		}
	},
	InstantPlayEffectParentInstanceNames = { "HumanoidRootPart>SFX>Laser" }
}