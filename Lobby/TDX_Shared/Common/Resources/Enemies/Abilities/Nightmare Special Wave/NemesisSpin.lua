local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	Animated = true,
	AnimationName = "Spin",
	StartingCooldown = 5,
	Cooldown = 35,
	Delay = 11 / 6,
	ExecutionTime = 7.633333333333333,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 15000 },
			Range = 15,
			HitAllTargetsInRange = true,
			CanTargetAir = true,
			NoTargetGround = true,
			NoAffectGround = true,
			MinimumTargetsInRange = 1
		}
	},
	HealData = {
		HealAmount = 80000,
		Delay = 19 / 6
	},
	EffectsStartDelay = 137 / 30,
	EffectsStopDelay = 91 / 15,
	InstantPlayEffectParentInstanceNames = { "FX>Spin>Immediate" },
	EffectParentInstanceNames = { "FX>Spin>Delayed" }
}