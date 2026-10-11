local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 45,
	Animated = true,
	Delay = 1.267,
	ExecutionTime = 3.4669999999999996,
	AnimationName = "CrossSlam",
	EnemyToTowerRangedDataSequence = {
		{
			MinimumTargetsInRange = 3,
			DamageData = { Damage = 500 },
			Range = 25,
			HitAllTargetsInRange = true,
			TowerBuffNames = { Enums.TowerBuffs.CorrApexPredSlamStun }
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		AffectPathEntitiesOnly = true,
		MaximumRange = 25,
		DamageData = { InstantKill = true }
	},
	EffectParentInstanceNames = { "SlamEffectPart" }
}