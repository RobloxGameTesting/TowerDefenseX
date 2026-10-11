local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 10,
	Cooldown = 14,
	Delay = 1.5,
	ExecutionTime = 2.3,
	AnimationName = "Slam",
	EffectParentInstanceNames = { "SlamEffects" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.MachoNachoSlamDebuff },
			Range = 20,
			HitAllTargetsInRange = true
		}
	}
}