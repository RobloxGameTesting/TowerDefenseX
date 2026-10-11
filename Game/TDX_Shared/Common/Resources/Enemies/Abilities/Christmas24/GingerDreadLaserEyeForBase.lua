local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 180,
	StartingCooldownVariance = 5,
	Cooldown = 45,
	Animated = true,
	Delay = 1.15,
	ExecutionTime = 3.7159999999999997,
	BurstSize = 8,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "LaserEye",
	FaceTarget = true,
	PrerequisiteAbilityName = { Enums.EnemyAbilities.GingerDreadRage, Enums.EnemyAbilities.GingerDreadRageNightmare },
	EnemyToMapEntityRangedData = {
		Damage = 750,
		Range = 60,
		MinimumRange = 10,
		BeamEffectHandlingData = {
			{ BeamParentInstanceName = "LaserEyeBeamPartForBase", BeamDuration = 0.867 }
		}
	},
	EffectParentInstanceNames = { "LaserEyeEffectsPart" },
	EffectsStartDelay = 0
}