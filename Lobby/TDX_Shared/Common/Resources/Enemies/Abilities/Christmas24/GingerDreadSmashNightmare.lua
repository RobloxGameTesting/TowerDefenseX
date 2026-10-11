local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 45,
	Animated = true,
	Delay = 1.667,
	ExecutionTime = 2.6,
	AnimationName = "Smash",
	SecondaryAnimationForKeyframeEventsName = "Damaged_Smash",
	EnemyToTowerRangedDataSequence = {
		{
			MinimumTargetsInRange = 3,
			DamageData = { Damage = 1000 },
			Range = 18,
			HitAllTargetsInRange = true,
			TowerBuffNames = { Enums.TowerBuffs.GingerDreadSmashStun }
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		AffectPathEntitiesOnly = true,
		MaximumRange = 18,
		DamageData = { InstantKill = true }
	},
	EffectParentInstanceNames = { "SmashEffectPart", "SmashEffectPart2" }
}