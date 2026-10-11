local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 2.05,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1000 },
			TowerBuffNames = { Enums.TowerBuffs.WretchLandStun },
			Range = 12,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MinimumTargets = 0,
		AffectPathEntitiesOnly = true,
		MaximumRange = 12,
		DamageData = { InstantKill = true }
	}
}