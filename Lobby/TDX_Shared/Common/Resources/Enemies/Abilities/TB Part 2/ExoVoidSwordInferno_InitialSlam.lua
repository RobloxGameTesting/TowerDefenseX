local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 1,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 2000 },
			Range = 25,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MinimumTargets = 0,
		AffectPathEntitiesOnly = true,
		MaximumRange = 25,
		DamageData = { Damage = 30000 }
	}
}