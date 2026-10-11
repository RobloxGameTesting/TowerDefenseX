local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 91 / 15,
	BurstSize = 23,
	BurstInterval = 0.2,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "FocusFireLong",
	AutoHandleEffects = true,
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.8,
	EffectsStartDelay = 1.4,
	EffectsStopDelay = 6.5,
	EnemyToMapEntityRangedData = {
		Damage = 31,
		Range = 1e999,
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "FocusFireLongBeam",
				BeamDuration = 5.1,
				OscillationXZ = 0.5,
				OscillationXZPeriod = 1.8,
				OscillationY = 0.4,
				OscillationYPeriod = 2.1
			}
		}
	}
}