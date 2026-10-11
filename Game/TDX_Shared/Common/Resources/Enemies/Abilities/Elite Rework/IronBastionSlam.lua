local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 10,
	Delay = 5 / 3,
	ExecutionTime = 2.85,
	Animated = true,
	AnimationName = "Slam",
	EffectParentInstanceNames = { "SlamEffects" },
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 10 },
			TowerBuffNames = { Enums.TowerBuffs.IronBastionStunDebuff },
			Range = 15,
			HitAllTargetsInRange = true
		}
	}
}