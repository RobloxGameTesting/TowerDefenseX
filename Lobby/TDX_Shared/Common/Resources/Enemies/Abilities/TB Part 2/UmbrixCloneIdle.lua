local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 1,
	CooldownVariance = 0.5,
	Animated = true,
	AnimationName = "CrystalCopyIdle",
	ForcePlayAnimationOnClientside = true,
	NoRestartAnimationIfAlreadyPlaying = true,
	StopAnimationDelay = 10,
	Delay = 0,
	ExecutionTime = 0,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 25,
		MinimumTargets = 0,
		MaximumTargets = 3,
		DamageData = { Damage = 100 }
	},
	AffectedEntityEffectData = {
		EffectName = Enums.VisualEffects.UmbrixCloneLaserFire,
		BeamEffectHandlingData = {
			{ BeamParentInstanceName = "Core>LaserBeam", MakeNewBeam = true, BeamDuration = 0.6 }
		}
	}
}