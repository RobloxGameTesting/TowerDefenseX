local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 27,
	Delay = 1.467,
	ExecutionTime = 2.8,
	Animated = true,
	AnimationName = "Slam",
	EffectParentInstanceNames = { "Slam" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.TheIlluminatiSlamDebuff },
			Range = 16,
			HitAllTargetsInRange = true
		}
	}
}