local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.EradicatorMKICGoldLaserSweepBurn },
	Range = 9.5,
	MinimumRange = 4,
	ArcSpreadAngle = 120,
	MinimumTargetsInRange = 2,
	TargetMinimumValue = 1000,
	EradicatorFlamethrowerData = {
		StartTime = 0.75,
		StopTime = 2.667,
		ArcTiming = {
			{ Time = 0.75, Angle = 78 },
			{ Time = 0.833, Angle = 78 },
			{ Time = 1.033, Angle = 0 },
			{ Time = 1.2, Angle = -77 }
		},
		BufferAngle = 16,
		AdditionalRangeForHit = 4
	}
}
return {
	StartingCooldown = 10,
	Cooldown = 25,
	Animated = true,
	Delay = 0.75,
	ExecutionTime = 2.267,
	AnimationName = "Laser Sweep",
	FaceTarget = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EradicatorMKICGoldRage,
	EffectParentInstanceNames = { "LaserSweepEffects" },
	EnemyToTowerRangedDataSequence = { v }
}