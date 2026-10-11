local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ConsiderTargetsWithNoAttack = true,
	TargetMostExpensiveTower = true,
	Range = 30,
	MinimumTargetsInRange = 1,
	TowerBuffNames = { Enums.TowerBuffs.UmbrixCrystalBeamStun, Enums.TowerBuffs.UmbrixCrystalBeamDamage },
	BeamEffectHandlingData = {
		{
			BeamParentInstanceName = "Core>CrystalBeamFX",
			BeamDuration = 1.5,
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		}
	}
}
return {
	StartingCooldown = 12,
	Cooldown = 30,
	Animated = true,
	AnimationName = "CrystalBeam",
	AutoHandleEffects = true,
	Delay = 2.3,
	ExecutionTime = 4.5,
	FaceTarget = true,
	ForceFaceOverideTime = 0.75,
	ForceFaceOverideTimeInitial = 0.25,
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 8,
		BuffName = Enums.TowerBuffs.UmbrixCrystalBeamSplashDamage
	},
	EnemyToTowerRangedDataSequence = { v }
}