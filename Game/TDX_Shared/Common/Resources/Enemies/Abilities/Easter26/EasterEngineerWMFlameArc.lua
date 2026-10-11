local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.EasterEngineerWMFlameDebuff },
	Range = 28,
	MinimumRange = 5,
	ArcSpreadAngle = 75,
	MinimumTargetsInRange = 2,
	TargetMinimumValue = 1000,
	EradicatorFlamethrowerData = {
		StartTime = 1.433,
		StopTime = 6.8,
		ArcTiming = {
			{ Time = 1.433, Angle = 40 },
			{ Time = 2.25, Angle = 40 },
			{ Time = 2.4, Angle = 25 },
			{ Time = 2.75, Angle = 25 },
			{ Time = 2.95, Angle = 15 },
			{ Time = 3.033, Angle = 10 },
			{ Time = 3.267, Angle = 0 },
			{ Time = 3.6, Angle = -15 },
			{ Time = 3.817, Angle = -15 },
			{ Time = 4.15, Angle = -40 },
			{ Time = 4.95, Angle = -40 },
			{ Time = 5.533, Angle = 0 },
			{ Time = 5.917, Angle = 25 },
			{ Time = 6.15, Angle = 35 },
			{ Time = 6.8, Angle = 0 }
		},
		BufferAngle = 16,
		AdditionalRangeForHit = 3
	}
}
return {
	StartingCooldown = 18,
	Cooldown = 25,
	Animated = true,
	Delay = 1.433,
	ExecutionTime = 8.133000000000001,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_WarMachine,
	AnimationName = "WMFlameArc",
	FaceTarget = true,
	ForceFaceOverideTime = 0.5,
	ForceFaceOverideTimeInitial = 0.8,
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = { "WMFlamethrower" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>WMFlameArc" }
}