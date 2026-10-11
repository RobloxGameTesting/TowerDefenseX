local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.GingerDreadLaserSweepBurn },
	Range = 11.5,
	MinimumRange = 6.5,
	ArcSpreadAngle = 100,
	MinimumTargetsInRange = 2,
	TargetMinimumValue = 800,
	EradicatorFlamethrowerData = {
		StartTime = 1.6,
		StopTime = 3,
		ArcTiming = {
			{ Time = 0.75, Angle = -60 },
			{ Time = 1.833, Angle = -60 },
			{ Time = 2.583, Angle = 0 },
			{ Time = 3, Angle = 60 }
		},
		BufferAngle = 16,
		AdditionalRangeForHit = 4
	}
}
return {
	StartingCooldown = 10,
	Cooldown = 40,
	Animated = true,
	Delay = 1.6,
	ExecutionTime = 4.6,
	AnimationName = "LaserSweep",
	FaceTarget = true,
	PrerequisiteAbilityName = { Enums.EnemyAbilities.GingerDreadRage, Enums.EnemyAbilities.GingerDreadRageNightmare },
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = { "LaserSweepEffects" },
	EffectsStartDelay = 0
}