local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 25,
	Animated = true,
	Delay = 2,
	ExecutionTime = 5.9830000000000005,
	AnimationName = "Ice Breath",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = {
				Enums.TowerBuffs.GeneralCelgarIceBreathBurn,
				Enums.TowerBuffs.GeneralCelgarIceBreathFreeze
			},
			Range = 14,
			MinimumRange = 2,
			ArcSpreadAngle = 100,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 800,
			EradicatorFlamethrowerData = {
				StartTime = 2,
				StopTime = 3.2,
				ArcTiming = {
					{ Time = 2, Angle = -60 },
					{ Time = 2.4, Angle = -60 },
					{ Time = 2.9, Angle = 0 },
					{ Time = 3.05, Angle = 60 },
					{ Time = 3.2, Angle = 60 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 4
			}
		}
	},
	EffectParentInstanceNames = { "IceBreath" },
	EffectsStartDelay = 0
}