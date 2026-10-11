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
	Delay = 1.85,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.SlimeKingJumpStun },
			Range = 9,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MinimumTargets = 0,
		AffectPathEntitiesOnly = true,
		MaximumRange = 9,
		DamageData = { InstantKill = true }
	}
}