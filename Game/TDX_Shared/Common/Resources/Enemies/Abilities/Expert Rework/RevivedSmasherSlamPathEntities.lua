local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 3,
	Cooldown = 24,
	Delay = 1.4,
	ExecutionTime = 2.133,
	AnimationName = "Swipe",
	EffectParentInstanceNames = { "SwipeEffects" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.RevivedSmasherSlamDebuff },
			DamageData = { Damage = 400 },
			TargetPathEntitiesIfNoTowers = true,
			PathEntityInitialQueryReduceRange = 7,
			TargetMinimumValue = 1e999,
			Range = 10,
			HitAllTargetsInRange = true
		}
	}
}