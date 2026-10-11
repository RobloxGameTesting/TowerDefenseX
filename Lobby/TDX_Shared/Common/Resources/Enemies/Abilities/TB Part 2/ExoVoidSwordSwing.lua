local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 20,
	Animated = true,
	AnimationName = "SwordSwing",
	Delay = 0.833,
	ExecutionTime = 1.5,
	AutoHandleEffects = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 2500 },
			Range = 16,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MinimumTargets = 0,
		AffectPathEntitiesOnly = true,
		MaximumRange = 16,
		DamageData = { InstantKill = true }
	}
}