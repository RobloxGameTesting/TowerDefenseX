local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 45,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.4669999999999996,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "SpawnRageScreamVFXTop", "SpawnRageScreamVFXBottom" },
	EffectsStopDelay = 1.567,
	EnemyToTowerRadiusEffectData = {
		DamageData = { Damage = 0 },
		TowerBuffNames = { Enums.TowerBuffs.CorruptedPredatorScreamStun },
		MinimumTargets = 1,
		AffectTargetsWithNoAttack = true
	}
}