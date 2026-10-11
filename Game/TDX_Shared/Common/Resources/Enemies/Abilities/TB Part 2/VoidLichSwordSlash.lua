local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 13,
	Animated = true,
	Delay = 1,
	ExecutionTime = 1.8,
	EffectsStartDelay = 0.8,
	EffectsStopDelay = 1.1,
	AutoHandleEffects = true,
	FaceTarget = true,
	AnimationName = "SwordSlash",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1000 },
			Range = 8,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		AffectPathEntitiesOnly = true,
		MaximumRange = 8,
		DamageData = { InstantKill = true }
	}
}