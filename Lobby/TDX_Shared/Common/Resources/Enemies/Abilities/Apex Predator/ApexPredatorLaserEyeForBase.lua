local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 25,
	Cooldown = 75,
	Animated = true,
	Delay = 1.6,
	ExecutionTime = 3.7159999999999997,
	BurstSize = 8,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "LaserEye",
	FaceTarget = true,
	EnemyToMapEntityRangedData = {
		Damage = 500,
		Range = 60,
		MinimumRange = 10,
		BeamEffectHandlingData = {
			{ BeamParentInstanceName = "LaserEyeBeamPartForBase", BeamDuration = 0.867 }
		}
	},
	EffectParentInstanceNames = { "LaserEyeEffectsPart" }
}