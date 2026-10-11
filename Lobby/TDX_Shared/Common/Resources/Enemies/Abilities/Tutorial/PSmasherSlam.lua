local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 37,
	Animated = true,
	Delay = 1.917,
	ExecutionTime = 3.133,
	AnimationName = "Slam",
	EffectParentInstanceNames = { "SmashEffects" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.PSmasherSlamDebuff },
			Range = 10,
			HitAllTargetsInRange = true
		}
	}
}