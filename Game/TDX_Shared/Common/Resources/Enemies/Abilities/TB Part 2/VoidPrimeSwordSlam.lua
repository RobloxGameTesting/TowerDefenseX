local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 42,
	Animated = true,
	Delay = 19 / 12,
	ExecutionTime = 3.933,
	AnimationName = "SwordSlam",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.VoidPrimeSwordSlamFirerateDebuff },
			DamageData = { Damage = 1000 },
			Range = 25,
			HitAllTargetsInRange = true
		}
	},
	InstantPlayEffectParentInstanceNames = { "SwordSlamSFX" },
	EffectParentInstanceNames = { "SwordSlamVFX" }
}