local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.BunnyTank900LaserSweepDamage },
	Range = 12,
	MinimumRange = 4,
	ArcSpreadAngle = 360,
	MinimumTargetsInRange = 4,
	EradicatorFlamethrowerData = {
		StartTime = 0.433,
		StopTime = 5.4,
		ArcTiming = {
			{ Time = 0.433, Angle = 0 },
			{ Time = 5.4, Angle = 5760 }
		},
		BufferAngle = 16,
		AdditionalRangeForHit = 4
	}
}
return {
	PrerequisiteAbilityName = Enums.EnemyAbilities.BunnyTank900Transition,
	StartingCooldown = 3,
	Cooldown = 30,
	Animated = true,
	Delay = 0.433,
	ExecutionTime = 6.7,
	AnimationName = "Phase 2 Laser Spin",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = { v },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>LaserSpin" },
	ParallelAbilityNames = { Enums.EnemyAbilities.BunnyTank900LaserSpinRockets },
	DisableAbilityListWhileActive = { Enums.EnemyAbilities.BunnyTank900PassiveRockets }
}