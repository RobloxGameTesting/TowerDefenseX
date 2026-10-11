local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 3,
	Cooldown = 24,
	Delay = 1.5,
	ExecutionTime = 2.8,
	AnimationName = "Smash",
	EffectParentInstanceNames = { "SmashEffects" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.RevivedSmasherSlamDebuff },
			DamageData = { Damage = 250 },
			Range = 10,
			HitAllTargetsInRange = true
		}
	}
}