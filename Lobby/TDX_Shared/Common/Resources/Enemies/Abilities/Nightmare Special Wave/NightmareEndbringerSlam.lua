local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 15,
	Delay = 1.767,
	ExecutionTime = 4.133,
	Animated = true,
	AnimationName = "Slam",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 5000 },
			Range = 14,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MinimumTargets = 0,
		AffectPathEntitiesOnly = true,
		MaximumRange = 12,
		DamageData = { Damage = 125000 }
	},
	EffectParentInstanceNames = { "SlamEffectPart" }
}