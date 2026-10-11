local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.EasterEngineerEradStrafeDebuff },
	Range = 32,
	MinimumRange = 8,
	ArcSpreadAngle = 50,
	MinimumTargetsInRange = 4,
	TargetMinimumValue = 2000,
	EradicatorFlamethrowerData = {
		StartTime = 2,
		StopTime = 5,
		ArcTiming = {
			{ Time = 2, Angle = 30 },
			{ Time = 3, Angle = 30 },
			{ Time = 3.467, Angle = 5 },
			{ Time = 3.567, Angle = 0 },
			{ Time = 3.9, Angle = -20 },
			{ Time = 5, Angle = -20 }
		},
		BufferAngle = 16,
		AdditionalRangeForHit = 10
	}
}
return {
	StartingCooldown = 15,
	Cooldown = 75,
	Animated = true,
	AnimationName = "EradStrafe",
	Delay = 2,
	ExecutionTime = 6.3,
	FaceTarget = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_Eradicator,
	EffectParentInstanceNames = { "EradStrafe" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>EradStrafe" },
	EnemyToTowerRangedDataSequence = { v }
}