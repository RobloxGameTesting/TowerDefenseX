local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 30,
	Animated = true,
	Delay = 1.55,
	ExecutionTime = 3.3,
	AnimationName = "Slam",
	EffectParentInstanceNames = { "SmashEffects" },
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 50 },
			TowerBuffNames = { Enums.TowerBuffs.CrushaSlamDebuff },
			Range = 12,
			HitAllTargetsInRange = true
		}
	}
}