local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 30,
	Animated = true,
	Delay = 0.9167,
	ExecutionTime = 1.883,
	AnimationName = "Stun",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.PlagueDoctorStunDebuff },
			Range = 10,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "StunEffectPart"
		}
	},
	HealData = { HealAmount = 8750 }
}