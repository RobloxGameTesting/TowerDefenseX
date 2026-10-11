local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 22,
	Animated = true,
	Delay = 1.25,
	ExecutionTime = 3.4499999999999997,
	AnimationName = "FlameBreath",
	FaceTarget = true,
	ForceFaceOverideTime = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = {
				Enums.TowerBuffs.CyberDragonFlameBreathBurn,
				Enums.TowerBuffs.CyberDragonFlameFirerateDebuff
			},
			Range = 12,
			MinimumRange = 5,
			ArcSpreadAngle = 100,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 800,
			EradicatorFlamethrowerData = {
				StartTime = 1.5,
				StopTime = 3,
				ArcTiming = {
					{ Time = 1.25, Angle = 45 },
					{ Time = 1.383, Angle = 45 },
					{ Time = 2, Angle = 0 },
					{ Time = 2.283, Angle = -45 },
					{ Time = 2.5, Angle = -45 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 3
			}
		}
	},
	EffectParentInstanceNames = { "FlameBreath" },
	EffectsStartDelay = 0
}