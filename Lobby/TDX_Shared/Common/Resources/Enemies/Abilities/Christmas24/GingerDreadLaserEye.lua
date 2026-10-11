local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = false,
	TowerBuffNames = { Enums.TowerBuffs.GingerDreadLaserEyeBurn },
	Range = 120,
	MinimumRange = 10,
	TargetMostExpensiveTower = true,
	BeamEffectHandlingData = {
		{ BeamParentInstanceName = "LaserEyeBeamPart", BeamDuration = 0.8 }
	}
}
return {
	StartingCooldown = 12,
	Cooldown = 35,
	Animated = true,
	Delay = 1.15,
	ExecutionTime = 3.7159999999999997,
	AnimationName = "LaserEye",
	FaceTarget = true,
	PrerequisiteAbilityName = { Enums.EnemyAbilities.GingerDreadRage, Enums.EnemyAbilities.GingerDreadRageNightmare },
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = { "LaserEyeEffectsPart" },
	EffectsStartDelay = 0
}