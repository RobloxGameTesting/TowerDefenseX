local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	ExecutionTime = 0,
	CanRunInParallel = true,
	Delay = 0.6,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = {
				Damage = 0,
				DamageFalloffRanges = {
					{ Range = 3, Damage = 500 },
					{ Range = 5, Damage = 300 },
					{ Range = 7, Damage = 200 },
					{ Range = 10, Damage = 100 }
				}
			},
			Range = 10,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = {}
}