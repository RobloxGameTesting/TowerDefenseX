local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 45,
	Animated = true,
	Delay = 2.233,
	ExecutionTime = 3.7500000000000004,
	AnimationName = "AxeSlam",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.ApexPredatorSlamStunDebuff },
			DamageData = { Damage = 1000 },
			Range = 18,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SlamEffectPart"
		}
	},
	EffectParentInstanceNames = {}
}