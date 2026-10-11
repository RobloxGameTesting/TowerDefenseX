local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 20,
	Cooldown = 45,
	Animated = true,
	Delay = 1,
	ExecutionTime = 7.3,
	EffectsStopDelay = 5.2,
	AutoHandleEffects = true,
	BurstSize = 8,
	BurstInterval = 0.6,
	AnimationName = "SwordStab",
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 28,
		DamageData = { Damage = 100 }
	}
}