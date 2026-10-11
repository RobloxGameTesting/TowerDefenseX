local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.EasterEngineerPredLaserDebuff },
	Range = 28,
	MinimumRange = 8,
	ArcSpreadAngle = 75,
	MinimumTargetsInRange = 2,
	TargetMinimumValue = 2000,
	EradicatorFlamethrowerData = {
		StartTime = 1.3,
		StopTime = 1.7,
		ArcTiming = {
			{ Time = 1.3, Angle = 40 },
			{ Time = 1.5, Angle = 40 },
			{ Time = 1.733, Angle = 0 },
			{ Time = 2, Angle = -40 }
		},
		BufferAngle = 16,
		AdditionalRangeForHit = 3
	}
}
return {
	StartingCooldown = 15,
	Cooldown = 22,
	Animated = true,
	Delay = 1.3,
	ExecutionTime = 3.3,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_Predator,
	AnimationName = "PredLaserArc",
	FaceTarget = true,
	ForceFaceOverideTime = 0.5,
	ForceFaceOverideTimeInitial = 0.8,
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>PredLaserArc" }
}