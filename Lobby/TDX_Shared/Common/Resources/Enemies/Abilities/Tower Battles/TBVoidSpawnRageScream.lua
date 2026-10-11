local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 1,
	Animated = true,
	Delay = 1.517,
	ExecutionTime = 3.0330000000000004,
	AnimationName = "SpawnRageScream",
	EffectParentInstanceNames = { "SpawnRageScreamVFXTop", "SpawnRageScreamVFXBottom" },
	EffectsStopDelay = 2.583,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.VoidSpawnRageScreamStun },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		AffectPathEntitiesOnly = true,
		DamageData = { InstantKill = true },
		MinimumTargets = 0,
		AffectTargetsWithNoAttack = true,
		PathEntityTypeIgnoreMap = {}
	}
}