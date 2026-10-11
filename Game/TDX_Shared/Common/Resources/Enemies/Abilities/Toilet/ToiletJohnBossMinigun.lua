local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 50,
	Animated = true,
	Delay = 0.8,
	ExecutionTime = 5,
	AnimationName = "Minigun",
	EffectParentInstanceNames = {},
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.ToiletJohnBossMinigunDebuff },
			Range = 35,
			ArcSpreadAngle = 110,
			EradicatorFlamethrowerData = {
				StartTime = 0.8,
				StopTime = 4.8,
				ArcTiming = {
					{ Time = 0.8, Angle = -55 },
					{ Time = 4.8, Angle = 55 }
				},
				BufferAngle = 16
			},
			MinimumTargetsInRange = 4
		}
	}
}