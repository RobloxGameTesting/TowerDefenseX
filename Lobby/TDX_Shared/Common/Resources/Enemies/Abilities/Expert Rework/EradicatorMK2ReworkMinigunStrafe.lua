local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 75,
	Animated = true,
	AnimationName = "MinigunStrafe",
	Delay = 2.65,
	ExecutionTime = 8.55,
	FaceTarget = true,
	InstantPlayEffectParentInstanceNames = { "Minigun>SFX" },
	EffectParentInstanceNames = {
		"Minigun>LeftLowerMachineGun",
		"Minigun>LeftUpperMachineGun",
		"Minigun>RightLowerMachineGun",
		"Minigun>RightUpperMachineGun"
	},
	EnemyToTowerRangedDataSequence = {
		{
			TargetPathIfNoTargets = true,
			TowerBuffNames = { Enums.TowerBuffs.EradicatorMK2ReworkMinigunStrafeDebuff },
			Range = 25,
			ArcSpreadAngle = 85,
			MinimumTargetsInRange = 2,
			TargetMinimumValue = 800,
			EradicatorFlamethrowerData = {
				StartTime = 2.65,
				StopTime = 7.15,
				ArcTiming = {
					{ Time = 2.65, Angle = -45 },
					{ Time = 3.383, Angle = -45 },
					{ Time = 5.533, Angle = 0 },
					{ Time = 7.15, Angle = 45 }
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 10
			}
		}
	}
}